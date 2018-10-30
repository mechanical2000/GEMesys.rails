require "rails_helper"

describe Agilibox::Email, type: :model do
  it { is_expected.to respond_to :current_user }
  it { is_expected.to respond_to :reply_to }
  it { is_expected.to respond_to :from }
  it { is_expected.to respond_to :to }
  it { is_expected.to respond_to :cc }
  it { is_expected.to respond_to :subject }
  it { is_expected.to respond_to :body }
  it { is_expected.to respond_to :attachments }

  describe "default values" do
    it "should assign default values" do
      expect_any_instance_of(described_class).to receive(:default_from).and_return("from")
      expect_any_instance_of(described_class).to receive(:default_reply_to).and_return("reply_to")
      expect_any_instance_of(described_class).to receive(:default_to).and_return("to")
      expect_any_instance_of(described_class).to receive(:default_cc).and_return("cc")
      expect_any_instance_of(described_class).to receive(:default_subject).and_return("subject")
      expect_any_instance_of(described_class).to receive(:default_body).and_return("body")
      expect_any_instance_of(described_class).to receive(:default_attachments).and_return("attach")

      email = described_class.new

      expect(email.from).to eq "from"
      expect(email.reply_to).to eq "reply_to"
      expect(email.to).to eq "to"
      expect(email.cc).to eq "cc"
      expect(email.subject).to eq "subject"
      expect(email.body).to eq "body"
      expect(email.attachments).to eq "attach"
    end

    describe "#default_reply_to" do
      it "should be nil if current_user is nil" do
        default_reply_to = described_class.new.send(:default_reply_to)
        expect(default_reply_to).to eq nil
      end

      it "should be current_user if present" do
        user = OpenStruct.new(email: "alice@example.org")
        expect(user).to receive(:to_s).at_least(:once).and_return("Alice")
        default_reply_to = described_class.new(current_user: user).send(:default_reply_to)
        expect(default_reply_to).to eq "Alice <alice@example.org>"
      end
    end # describe "#default_reply_to"
  end # describe "default values"

  describe "#data" do
    it "should return hash of email data" do
      mail = described_class.new(
        :current_user => OpenStruct.new,
        :from         => "from@example.org",
        :reply_to     => "reply_to@example.org",
        :to           => "to@example.org",
        :cc           => "cc@example.org",
        :subject      => "Subject",
        :body         => "Body",
        :attachments  => {"filename.txt" => "hello"},
      )

      expect(mail.data).to eq(
        :from         => "from@example.org",
        :reply_to     => "reply_to@example.org",
        :to           => "to@example.org",
        :cc           => "cc@example.org",
        :subject      => "Subject",
        :body         => "Body",
        :attachments  => {"filename.txt" => "hello"},
      )
    end
  end # describe "#data"

  describe "validations" do
    it { is_expected.to validate_presence_of :to }
    it { is_expected.to validate_presence_of :subject }
    it { is_expected.to validate_presence_of :body }

    it { is_expected.to_not validate_presence_of :from }
    it { is_expected.to_not validate_presence_of :reply_to }
    it { is_expected.to_not validate_presence_of :cc }
    it { is_expected.to_not validate_presence_of :attachments }

    %w(from reply_to to cc).each do |addr_type|
      it "should validate :#{addr_type} format" do
        email = described_class.new

        expect(email).to allow_value("user@example.org").for(addr_type)
        expect(email).to allow_value("user1@example.org,user2@example.org").for(addr_type)
        expect(email).to allow_value("user1@example.org;user2@example.org").for(addr_type)
        expect(email).to allow_value("User <user@example.com>").for(addr_type)
        expect(email).to allow_value("<user@example.com>").for(addr_type)
        expect(email).to allow_value("User <user@example.com>;user2@example.org").for(addr_type)

        expect(email).to_not allow_value("user").for(addr_type)
        expect(email).to_not allow_value("user@example.com>").for(addr_type)
        expect(email).to_not allow_value("<user@example.com").for(addr_type)
        expect(email).to_not allow_value("valid@example.com;invalid").for(addr_type)
      end
    end
  end # describe "validations" do

  describe "#validate_and_deliver" do
    it "should call #deliver if valid" do
      email = described_class.new
      expect(email).to receive(:valid?).and_return(true)
      expect(email).to receive(:deliver)
      expect(email.validate_and_deliver).to eq true
    end

    it "should not call #deliver if invalid" do
      email = described_class.new
      expect(email).to receive(:valid?).and_return(false)
      expect(email).to_not receive(:deliver)
      expect(email.validate_and_deliver).to eq false
    end
  end # describe "#validate_and_deliver"

  describe "delivery" do
    let(:email) { described_class.new }
    let(:mailer) { Agilibox::GenericMailer }
    let(:delivery) { double("delivery") }

    it "#deliver should user #deliver_now" do
      email = described_class.new
      expect(email).to receive(:deliver_now)
      email.deliver
    end

    it "#deliver_now should call generic mailer" do
      expect(mailer).to receive(:generic_email).with(email.data).and_return(delivery)
      expect(delivery).to receive(:deliver_now)
      described_class.new.deliver_now
    end

    it "#deliver_later should call generic mailer" do
      expect(mailer).to receive(:generic_email).with(email.data).and_return(delivery)
      expect(delivery).to receive(:deliver_later)
      described_class.new.deliver_later
    end

    it "should deliver email" do
      email = described_class.new(
        :from         => "from@example.org",
        :reply_to     => "reply_to@example.org",
        :to           => "to@example.org",
        :cc           => "cc@example.org",
        :subject      => "Subject",
        :body         => "Body",
        :attachments  => {"filename.txt" => "hello"},
      )

      expect { email.validate_and_deliver }.to change(email_deliveries, :count).by(1)
    end
  end # describe "delivery"
end
