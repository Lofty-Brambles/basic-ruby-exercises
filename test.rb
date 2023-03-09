# frozen_string_literal: true

require 'date'

def parseDate(date)
  captures = date.match(/^(\d+)\/(\d+)\/(\d+)\s(\d+):(\d+)/).captures
  time_subs = [captures[1].to_i, captures[2].to_i, captures[4].to_i, captures[5].to_i]
  Date.new(2000 + captures[3].to_i, *time_subs)
end

p parseDate("11/12/08 10:47")