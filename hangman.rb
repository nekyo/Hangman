require "./computer_player.rb"
require "./human_player.rb"
require "debugger"

class Hangman
  
  attr_accessor :tester, :guesser, :known_word_array
  
  def initialize(tester_type,guesser_type)
    #debugger
    case tester_type.downcase.to_sym
    when :human then @tester = HumanPlayer.new(self)
    when :computer then @tester = ComputerPlayer.new(self)
    end
    case guesser_type.downcase.to_sym
    when :human then @guesser = HumanPlayer.new(self)
    when :computer then @guesser = ComputerPlayer.new(self)
    end
    @known_word_array = []
    run
  end
  
  def run
    @tester.make_word
    guess_count = 0
    
    while @known_word_array.include?("_") && guess_count < 6
      puts "You currently know the following: #{@known_word_array.join("")}"
      guess = set_guess(guess_count)
      positions = get_positions(guess)

      @tester.restrict_dictionary_by_bad_letter(guess) if @tester.is_a?(ComputerPlayer)
      
      positions.each{|i| @known_word_array[i] = guess}
      
      guess_count += 1 if positions == nil
    end
    
    victory
  end
  
  private
  
  def set_guess(count)
    puts "You have used #{count} guesses"
    @guesser.guess
  end
  
  def get_positions(guess)
    puts "The guesser has guessed #{guess}"
    @tester.get_positions(guess)
  end
  
  def victory
    if @known_word_array.include?("_")
      puts "Sorry, guesser, you lose"
    else
      puts "Final word was: #{@known_word_array.join("")}"
      puts "Congratulations guesser! You win!"
    end
  end
end

#hangman_game = Hangman.new("computer","computer")