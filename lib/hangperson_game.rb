class HangpersonGame

  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def guess(word)
    if word == '' || word == nil || /[^a-z]/i.match(word)
      raise ArgumentError.new('Argument Error')
    end
    
    word.downcase!  
      
    if @word.include? word
      if @guesses.include? word
        return false
      else
        @guesses.concat(word)
        return true
      end
    elsif !@word.include? word
      if @wrong_guesses.include? word
        return false
      else
        @wrong_guesses.concat(word)
        return true
      end
    end
  end
    
  def word_with_guesses
    result = ''
    @word.each_char do |letter|
      if !@guesses.include? letter
        result.concat('-')
      else
        result.concat(letter)
      end
    end
    
    return result
  end
  
  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    elsif @guesses.chars.sort.join == @word.chars.sort.join
      return :win
    else
      return :play
    end
  end
  
  # helper function: make several guesses
  def guess_several_letters(letters)
    letters.chars do |letter|
      guess(letter)
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
