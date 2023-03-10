s = 'sdsdsds\n'
pl = 'dewe'

[s, pl].each { |word| p word.end_with?('\n') ? word[0..-3] : word }