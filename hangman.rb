raw_google_dict = "google-10000-english-no-swears.txt"
dictionary = File.open(raw_google_dict, "r")
word_array = dictionary.readlines
word_array.select! {|word| word.length >= 5 && word.length <= 12}


secret_word = word_array[rand(word_array.length)].gsub("\n", "")
word_in_progress = secret_word.split("").map{"_"}

guessed_letters = []

stickman_0 = <<~STICKMAN
------
  |  |
     |
     |
     |
     |
STICKMAN

stickman_1 = <<~STICKMAN
------
  |  |
  O  |
     |
     |
     |
STICKMAN

stickman_2 = <<~STICKMAN
------
  |  |
  O  |
   \\ |
     |
     |
STICKMAN

stickman_3 = <<~STICKMAN
------
  |  |
  O  |
 / \\ |
     |
     |
STICKMAN

stickman_4 = <<~STICKMAN
------
  |  |
  O  |
 /|\\ |
     |
     |
STICKMAN

stickman_5 = <<~STICKMAN
------
  |  |
  O  |
 /|\\ |
 /   |
     |
STICKMAN

stickman_6 = <<~STICKMAN
------
  |  |
  O  |
 /|\\ |
 / \\ |
     |
STICKMAN

stickmen = [stickman_0, stickman_1, stickman_2, stickman_3, stickman_4, stickman_5, stickman_6]

stickman = stickman_0

valid_chars = %w{a b c d e f g h i j k l m n o p q r s t u v w x y z}

win = false
p secret_word

while stickman != stickman_6 && !win
  puts stickman
  p word_in_progress
  puts guessed_letters

  loop do 
    guess = gets.chomp.downcase
    if valid_chars.include?(guess)
      break
    end
    puts "\"#{guess}\" is an invalid letter. Please try again."
  end

	# already guessed this letter!
	if guessed_letters.include?(guess)
    puts "You already tried the letter #{guess}. Try a different one."
	# guess a letter? => add 
  elsif secret_word.include?(guess)
    secret_word.split("").each_with_index do |let, ind|
      word_in_progress[ind] = let if guess == let;
    end
	# wrong letter!
	elsif !secret_word.include?(guess)
    stickman = stickmen[stickmen.index(stickman) + 1]
  end

  guessed_letters.push(guess) if !guessed_letters.include?(guess)

  if word_in_progress.join == secret_word
    win = true
  end

end

puts stickman
puts "you win!"