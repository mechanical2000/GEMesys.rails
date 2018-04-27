require "rails_helper"

describe Agilibox::FontAwesomeHelper do
  describe "#icon" do
    it "should generate icon and autodetect fas style" do
      expect(icon :user).to eq %(<span class="fa-user fas icon"></span>)
    end

    it "should generate icon and autodetect fab style" do
      expect(icon :twitter).to eq %(<span class="fa-twitter fab icon"></span>)
    end

    it "should generate icon using provided style" do
      expect(icon :user, fa_style: :regular).to eq %(<span class="fa-user far icon"></span>)
    end

    it "should accept size option" do
      expected_tag = %(<span class="fa-lg fa-user fas icon"></span>)
      generated_tag = icon(:user, size: :lg)

      expect(generated_tag).to eq expected_tag
    end

    it "should accept spin option" do
      expected_tag = %(<span class="fa-spin fa-spinner fas icon"></span>)
      generated_tag = icon(:spinner, spin: true)

      expect(generated_tag).to eq expected_tag
    end

    it "should accept html attributes" do
      expected_tag = %(<span class="fa-user fas icon" style="color:blue"></span>)
      generated_tag = icon(:user, style: "color:blue")

      expect(generated_tag).to eq expected_tag
    end

    it "should merge class attribute" do
      expected_tag = %(<span class="fa-user fas hello icon world"></span>)
      generated_tag = icon(:user, class: "hello world")

      expect(generated_tag).to eq expected_tag
    end
  end # describe "icon"

  it "::version should return real fa version" do
    expect(described_class.version).to eq FontAwesome::Sass::VERSION
  end

  describe "database methods" do
    it "should return database path" do
      base_path = Rails.root.join("tmp", "fa_database_").to_s
      expect(described_class.database_path.to_s).to start_with base_path
    end

    it "should cache database in memory" do
      described_class.instance_variable_set(:@database, nil)

      expect(described_class).to receive(:database_yml).once.and_call_original
      described_class.database
      described_class.database
    end

    it "should cache database in a file" do
      FileUtils.rm(described_class.database_path)
      expect(described_class.database_path).to_not exist

      expect(described_class).to receive(:download_database!).once.and_call_original
      described_class.database_yml
      described_class.database_yml

      expect(described_class.database_path).to exist
    end
  end # describe "database"
end
