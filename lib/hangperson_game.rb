class HangpersonGame
  attr_reader :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    if letter =~ /[a-zA-Z]/
      letter = letter.downcase
      if @word.include? letter
        if !@guesses.include? letter
          @guesses += letter          
          @wrong_guesses += ""
          true
        else
          false
        end
      else
        if !@wrong_guesses.include? letter
          @guesses += ""
          @wrong_guesses += letter
          true
        else
          false
        end
      end
    else
      raise ArgumentError
    end
  end
  
  def word_with_guesses(str = "-" * @word.length)
    to_guess = @word.split("")
    to_guess.each_with_index do |letter, index|
      if @guesses.include? letter
        str[index] = letter
      end
    end
    str
  end
  
  def check_win_or_lose
    if @wrong_guesses.size >= 7
      :lose
    elsif word_with_guesses == @word
      :win
    else
      :play
    end
  end
end
