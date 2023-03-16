# frozen_string_literal: true

# the main program
class Calculator
  def add(*args)
    args.reduce(:+)
  end

  def substract(first, second)
    first - second
  end

  def multiply(*args)
    args.reduce(1, :*)
  end

  def divide(first, second)
    first / second
  end
end
