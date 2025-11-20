require_relative '../lib/m2api.rb'

describe M2api::ProductAttribute do
  before(:all) do
    M2api.logger = Logger.new STDOUT, {:level => Logger::ERROR}
  end

  context "#dataset" do
    let(:dataset) {M2api::ProductAttribute.dataset}
    it "returns dataset" do
      expect(dataset).to be_a M2api::Dataset
    end
  end

  context "#all" do
    let(:attributes) {M2api::ProductAttribute.all}

    it "responds to all" do
      expect(M2api::ProductAttribute).to respond_to :all
    end
    it "returns an array" do
      expect(attributes).to be_a Array
    end
  end

  context "#first" do
    let(:attribute) {M2api::ProductAttribute.first}

    it "returns a product attribute" do
      expect(attribute).to be_a M2api::ProductAttribute
    end
  end

  context "#[]" do
    let(:first_attribute) {M2api::ProductAttribute.first}
    let(:by_code_attribute) {M2api::ProductAttribute[first_attribute.attribute_code]}

    it "returns a product attribute" do
      expect(by_code_attribute).to be_a M2api::ProductAttribute
    end

    it "returns attribute by :attribute_code" do
      expect(first_attribute.attribute_code).to eq by_code_attribute.attribute_code
    end
  end
end
