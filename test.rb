text_file = 'hangman/google-10000-english-no-swears.txt'
file = File.open(File.join(Dir.pwd, text_file), 'r')
words = file.readlines
words[-1] = words[-1] + "\n"
w = words[-7..-1]
file.close

word = w[-1]
p w
p 