require "rails_helper"

describe Agilibox::FCM::Notifier do
  it "should set default values" do
    notifier = described_class.new(to: "to", body: "body")
    expect(notifier.to).to    eq "to"
    expect(notifier.title).to eq nil
    expect(notifier.body).to  eq "body"
    expect(notifier.badge).to eq 0
    expect(notifier.sound).to eq "default"
    expect(notifier.data).to  eq({})
  end

  it "should set values" do
    notifier = described_class.new(
      :to    => "to",
      :title => "title",
      :body  => "body",
      :badge => 42,
      :sound => "sound",
      :data  => {n: 1},
    )

    expect(notifier.to).to    eq "to"
    expect(notifier.title).to eq "title"
    expect(notifier.body).to  eq "body"
    expect(notifier.badge).to eq 42
    expect(notifier.sound).to eq "sound"
    expect(notifier.data).to  eq(n: 1)
  end

  it "should call fcm request" do
    expect(Agilibox::FCM::Request).to receive(:call).with(
      :to => "to",
      :notification => {
        :title => "title",
        :body  => "body",
        :badge => 42,
        :sound => "sound",
      },
      :data => {n: 1},
    )

    described_class.call(
      :to    => "to",
      :title => "title",
      :body  => "body",
      :badge => 42,
      :sound => "sound",
      :data  => {n: 1},
    )
  end
end
