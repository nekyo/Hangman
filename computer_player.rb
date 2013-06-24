require 'debugger'

class ComputerPlayer
  attr_accessor :dictionary, :word_array, :game, :used_letters
  
  def initialize(game)
    
    @game = game
    @dictionary = File.readlines('./dictionary.txt')
    @dictionary.map!{|line| line.chomp.downcase}
    @used_letters = []
  end
  
  def guess
    
    restrict_dictionary_by_length
    restrict_dictionary_by_good_letters
    choice = find_most_common_letter
    @used_letters << choice
    choice
  end
  
  def get_positions(guess)
    indeces = []
    @word_array.each_with_index do |char,i|
      indeces << i if guess == char
    end
    indeces
  end

  def make_word
    random_line = rand(@dictionary.length - 1)
    @word_array = @dictionary[random_line].split(//)
    @word_array.count.times{@game.known_word_array << "_"}
  end
  
  def restrict_dictionary_by_bad_letter(letter)
    @dictionary.select!{|word| !word.split(//).include?(letter)}
  end
  
  private
  def restrict_dictionary_by_length
    length = @game.known_word_array.length
    @dictionary.select!{|word| word.length == length}
  end
  
  def restrict_dictionary_by_good_letters
    
    @dictionary.select! do |word|
      known_letters_match?(word)
    end
    #
  end
  
  def known_letters_match?(word)
    match = true

    @game.known_word_array.each_with_index do |char,i|
      match = false if word[i] != char && char != "_"
    end

    match
  end
  
  def find_most_common_letter
    alphabet = ("a".."z").to_a
    frequency_array = create_freq_array
    
    most_common = 0
    most_common_letter = 'a'
    alphabet.each do |letter|
      if frequency_array[letter].nil?
      elsif frequency_array[letter] > most_common && !@used_letters.include?(letter)
        most_common_letter = letter
        most_common = frequency_array[letter]
      end
    end
    most_common_letter
  end
  
  def create_freq_array
    frequency = {}
    @dictionary.join("").split(//).each do |char|
      if frequency[char].nil?
        frequency[char] = 1
      else
        frequency[char] += 1
      end
    end
    frequency
  end
end