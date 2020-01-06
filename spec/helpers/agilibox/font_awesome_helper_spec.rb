require "rails_helper"

describe Agilibox::FontAwesomeHelper do
  describe "#icon v5" do
    before do
      expect(described_class.version).to start_with "5"
    end

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
      base_path = Rails.root.join("tmp/fa_database_").to_s
      expect(described_class.database_path.to_s).to start_with base_path
    end

    it "should cache database in memory" do
      described_class.instance_variable_set(:@database, nil)

      expect(described_class).to receive(:database_yml).once.and_call_original
      described_class.database
      described_class.database
    end

    it "should cache database in a file" do
      FileUtils.rm_f(described_class.database_path)
      expect(described_class.database_path).to_not exist

      expect(described_class).to receive(:download_database!).once.and_call_original
      described_class.database_yml
      described_class.database_yml

      expect(described_class.database_path).to exist
    end

    it "should return database_url for <5.5.0" do
      expected = "https://raw.githubusercontent.com/FortAwesome/Font-Awesome/5.5.0/advanced-options/metadata/icons.yml"
      expect(described_class).to receive(:version).and_return("5.5.0.0")
      expect(described_class.database_url).to eq expected
    end

    it "should return database_url for >=5.6.0" do
      expected = "https://raw.githubusercontent.com/FortAwesome/Font-Awesome/5.6.0/metadata/icons.yml"
      expect(described_class).to receive(:version).and_return("5.6.0.0")
      expect(described_class.database_url).to eq expected
    end
  end # describe "#icon v5"

  describe "#icon v4" do
    before do
      expect(described_class).to receive(:version).and_return("4.0.0")
    end

    it "should work" do
      expect(icon :user).to eq %(<span class="fa fa-user icon"></span>)
    end
  end # describe "#icon v4"

  it "should raise on previous version" do
    expect(described_class).to receive(:version).at_least(:once).and_return("3.0.0")

    expect { icon :user }.to raise_error(RuntimeError, "invalid font-awesome-sass version")
  end

  it "should raise on future version" do
    expect(described_class).to receive(:version).at_least(:once).and_return("6.0.0")

    expect { icon :user }.to raise_error(RuntimeError, "invalid font-awesome-sass version")
  end
end
