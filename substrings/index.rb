# frozen_string_literal: true

def substrings(string, subs)
  subs.each_with_object({}) do |word, hash|
    occurences = string.scan(Regexp.new(word, true)).length
    hash[word] = occurences if occurences.positive?
  end
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]
# => ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings('below', dictionary)
# => { "below" => 1, "low" => 1 }

puts substrings("Howdy partner, sit down! How's it going?", dictionary)
# => { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2,
#      "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }
