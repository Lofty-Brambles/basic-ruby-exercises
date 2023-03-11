# frozen_string_literal: true

def fibs(number = 0)
  arr = []
  number.times { |i| arr << ([0, 1].include?(i) ? i : arr[-1] + arr[-2]) }
  arr
end

def fibs_rec(number = 0)
  (0...number).map { |i| [0, 1].include?(i) ? i : fibs_rec(i).last(2).reduce(:+) }
end

trial_input = 8
p fibs(trial_input)
p fibs_rec(trial_input)
