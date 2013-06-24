class HumanPlayer
  attr_accessor :word_array, :game
  
  def initialize(game)
    @word_array = []
    @game = game
    
  end
  
  def guess
    @game.known_word_array.count.times{@word_array << "_"} if @word_array.empty?
    puts "What letter would you like to guess"
    gets.chomp
  end
  
  def get_positions(guess)
    puts "Is #{guess} in your word?"
    puts "If so, please enter the position(s) that it appears (starting at 0)."
    puts "Otherwise press enter."
    gets.chomp.split(//).map!{|i| i.to_i}
  end
  
  def make_word
    puts "How long is your word?"
    length = gets.chomp.to_i
    length.times{@game.known_word_array << "_"}
  end
  
end