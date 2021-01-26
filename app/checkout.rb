class Checkout

  attr_accessor :items, :promotional_rules

  def initialize(promotional_rules)
    # example
    #  {
    #   item: [
    #     {
    #       code: "001",
    #       min: 2,
    #       discounted_price: 8.50
    #     }
    #   ],
    #
    #   total: [
    #     {
    #       min: 60.00,
    #       discount_amount: 10,
    #       discount_type: :percentage
    #     }
    #   ]
    # }
    @promotional_rules = promotional_rules

    # example
    # [
    #   {
    #      item: {code: "001", price: "50.00", name: "Cherries"},
    #      qty: 2
    #   }
    # ]
    @items = []
  end

  def scan(item)
    found = items.detect { |i| i[:item].code == item.code }

    if found
      found[:qty] += 1
    else
      items << { item: item, qty: 1}
    end
  end

  def apply_item_discounts(item)
    qty = item[:qty]
    product = item[:item]

    subtotal = product.price * qty

    rules = promotional_rules[:item]

    rules.each do |rule|
      if rule[:code] == product.code && qty >= rule[:min]
        discounted_price = rule[:discounted_price]
        subtotal = discounted_price * qty
      end
    end

    subtotal
  end

  def apply_total_discounts(subtotal)
    rules = promotional_rules[:total]

    rules.each do |rule|

      if subtotal > rule[:min]
        if rule[:discount_type] == :percentage
          discount = subtotal / 100 * rule[:discount_amount]
          subtotal = subtotal - discount

        elsif rule[:discount_type] == :amount
          subtotal = subtotal - rule[:discount_amount]
        end
      end
    end

    subtotal
  end

  def total
    subtotal = 0

    items.each do |item|
      subtotal += apply_item_discounts(item)
    end

    total = apply_total_discounts(subtotal)

    # Round to 2 decimal places, would implement money library in real life
    total.to_f.round(2)
  end
end