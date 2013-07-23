require "spec_helper"
require "github/utils"

describe GitHub::Utils::Rating do

  before do
    @source = [  
      { "id" => "1", "author" => "Igor", "stats" => { "deletions" => 10, "insertions" => 3, "files" => 13 } },
      { "id" => "2", "author" => "Igor", "stats" => { "deletions" => 12, "insertions" => 32, "files" => 13 } },
      { "id" => "3", "author" => "Ivan", "stats" => { "deletions" => 10, "insertions" => 13, "files" => 13, "field" => [] } },
      { "id" => "4", "author" => "John", "stats" => { "deletions" => 1, "insertions" => 7, "files" => 13 } },
      { "id" => "5", "author" => "John", "stats" => { "deletions" => 92, "insertions" => 39, "files" => 13, "field" => "x" } }
    ]

    @rating = described_class.new(@source)
  end
  subject { @rating }

  its(:source) { should eq(@source) }

  describe "#sum" do

    it "should sum two numbers" do
      expect(@rating.sum(40, 2)).to eq(40 + 2) 
      expect(@rating.sum(40.0, 2.0)).to eq(40.0 + 2.0)
    end

    context "when first param can't .coerce second" do

      it "should add 1 to first param if second not nil" do
        expect(@rating.sum(41, "string")).to eq(41 + 1)
        expect(@rating.sum(41, Class)).to eq(41 + 1)
      end

      it "should add 0 to first param if second is nil" do
        expect(@rating.sum(42, nil)).to eq(42 + 0)
      end
    end
  end

  describe "#deep_key" do

    it "should return value from nested hashes by array of keys" do
      expect(@rating.deep_key(@source.first, ["stats", "deletions"])).to eq(10)
    end

    it "should return nil if given keypath doesn't exitsts" do
      expect(@rating.deep_key(@source.first, ["stats", "foo", "bar"])).to be_nil
    end

    it "should return given hash if array of keys isn't specified or empty" do
      expect(@rating.deep_key(@source.first)).to eq(@source.first)
      expect(@rating.deep_key(@source.first, [])).to eq(@source.first)
    end
  end

  describe "#build" do

    context "when block given" do

      it "should yield current rating and target value to specify its sum" do
        expected_rating = { "Igor" => 44, "John" => 186, "Ivan" => 20 }
        rating = @rating.build(subject: ["author"], target: ["stats", "deletions"]) do |sum, val|
            sum + val*2
        end

        expect(rating).to eq(expected_rating)
      end
    end

    context "when target wasn't specified" do

      it "should count number of items that belongs to :subject" do
        expected_rating = { "Igor" => 2, "John" => 2, "Ivan" => 1 }
        expect(@rating.build(subject: ["author"])).to eq(expected_rating)
      end
    end

    context "when default value given" do

      it "should start rating from given value" do
        expected_rating = { "Igor" => 12, "John" => 12, "Ivan" => 11 }
        expect(@rating.build(subject: ["author"], default: 10)).to eq(expected_rating)
      end
    end
  end
end