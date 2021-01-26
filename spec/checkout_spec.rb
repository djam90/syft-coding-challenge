require_relative '../app/checkout'
require_relative '../app/product'

RSpec.describe Checkout do

  let(:promotional_rules) do
    return {
      # Discounts based on individual items
      item: [
        {
          code: "001",
          min: 2,
          discounted_price: 8.50
        }
      ],

      # Discounts based on total checkout value
      total: [
        {
          min: 60.00,
          discount_amount: 10,
          discount_type: :percentage
        }
      ]
    }
  end

  let(:item1) { Product.new("Lavender heart", "001", 9.25) }
  let(:item2) { Product.new("Personalised cufflinks", "002", 45.00) }
  let(:item3) { Product.new("Kids T-shirt", "003", 19.95) }

  subject { described_class.new(promotional_rules) }

  it "Instantiates with promotional rules with type Checkout" do
    expect(subject).to be_an_instance_of(Checkout)
  end

  it "Can scan items and give a total" do
    subject.scan(item1)
    expect(subject.total).to eq(9.25)
  end

  it "Discounts based on rules example 1" do
    subject.scan(item1)
    subject.scan(item2)
    subject.scan(item3)

    expect(subject.total).to eq(66.78)
  end

  it "Discounts based on rules example 2" do
    subject.scan(item1)
    subject.scan(item3)
    subject.scan(item1)

    expect(subject.total).to eq(36.95)
  end

  it "Discounts based on rules example 3" do
    subject.scan(item1)
    subject.scan(item2)
    subject.scan(item1)
    subject.scan(item3)

    expect(subject.total).to eq(73.76)
  end
end