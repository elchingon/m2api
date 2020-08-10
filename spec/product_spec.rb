require_relative '../lib/m2api.rb'

describe M2api::Product do
  before(:all) do
    M2api.logger = Logger.new STDOUT, {:level => Logger::ERROR}
    @original_count = M2api::Product.count
  end

  context "#dataset" do
    let(:dataset) {M2api::Product.dataset}
    it "returns dataset" do
      # binding.pry
      expect(dataset).to be_a M2api::Dataset
    end
  end

  context "#count" do
    let(:count) {M2api::Product.count}
    it "responds to :count" do
      expect(M2api::Product).to respond_to :count
    end
    it "correct count" do
      expect(count).to eq @original_count
    end
    it "count is integer" do
      expect(count).to be_a Integer
    end
  end

  context "#all" do
    let(:products) {M2api::Product.all}
    let(:ds) {M2api::Product.dataset}

    it "responds to all" do
      expect(M2api::Product).to respond_to :all
    end
    it "returns an array" do
      expect(products).to be_a Array
    end
    it "requested all" do
      expect(products.count).to eq @original_count
    end
  end

  context "#fields" do
    let(:fields) {M2api::Product.fields}

    it "returns array of symbols" do
      expect(fields).to be_a Array
      fields.each do |field|
        expect(field).to be_a Symbol
      end
    end
  end

  context "#first" do
    let(:product) {M2api::Product.first}

    it "returns a product" do
      expect(product).to be_a M2api::Product
    end
  end

  context "#types" do
    let(:types) {M2api::Product.types}

    it "returns array" do
      expect(types).to be_a Array
    end
  end

  context "#[]" do
    let(:first_product) {M2api::Product.first}
    let(:by_sku_product) {M2api::Product[first_product.sku]}

    it "returns a product" do
      expect(by_sku_product).to be_a M2api::Product
    end

    it "returns product by :sku" do
      expect(first_product.sku).to eq by_sku_product.sku
    end
  end
end
