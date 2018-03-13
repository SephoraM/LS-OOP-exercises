class GuessingGame
  def initialize(range_start, range_end)
    @range_start = range_start
    @range_end = range_end
    @size_of_range = range_end - range_start
    reset
  end

  private

  attr_accessor :current_guess, :number
  attr_reader :guesses, :range_start, :range_end, :size_of_range

  def clear
    system('clear') || system('cls')
  end

  def reset
    @guesses = Math.log2(size_of_range).to_i + 1
    self.number = (range_start..range_end).to_a.sample
    reset_guess
  end

  def reset_guess
    self.current_guess = nil
  end

  def display_welcome
    clear
    puts "Hello. I'm thinking of a number between" \
         " #{range_start} and #{range_end}. "\
         "I'll give you #{guesses} guesses to try and figure out what it is."
    puts ""
  end

  def display_remaining_guesses
    puts "You have #{guesses} guesses remaining."
  end

  def request_guess
    loop do
      print "Enter a number between #{range_start} and #{range_end}: "
      self.current_guess = gets.chomp.to_i
      break if valid_guess?
      print "Invalid guess. "
    end
  end

  def display_guess_status
    status = too_high? ? "high" : "low"
    puts "Your guess is too #{status}"
    puts ""
  end

  def display_won
    puts "You win!"
  end

  def display_out_of_guesses
    puts "You are out of guesses. You lose."
  end

  def too_high?
    current_guess > number
  end

  def valid_guess?
    (range_start..range_end).include?(current_guess)
  end

  def out_of_guesses?
    guesses == 0
  end

  def decrement_guesses
    @guesses -= 1
  end

  def correct_guess?
    current_guess == number
  end

  public

  def play
    display_welcome
    loop do
      break if out_of_guesses?
      display_remaining_guesses
      request_guess
      break if correct_guess?
      display_guess_status
      decrement_guesses
      reset_guess
    end
    correct_guess? ? display_won : display_out_of_guesses
  end
end

game = GuessingGame.new(501, 1500)

game.play
