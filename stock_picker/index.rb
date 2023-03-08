# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength

def stock_picker(prices)
  pointer = [0, 1]
  left = 0
  right = 1
  max = 0
  while right < prices.length
    new_price = prices[right] - prices[left]
    if new_price.positive?
      if new_price > max
        max = new_price
        pointer = [left, right]
      end
    else
      left = right
    end
    right += 1
  end
  p pointer
end

# rubocop:enable Metrics/MethodLength

stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
# => [1,4]  # for a profit of $15 - $3 == $12
