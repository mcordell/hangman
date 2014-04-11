
class HangmanGame

    attr_accessor :target_word, :char_map, :max_limbs, :current_limbs, :guess_list

    def initialize(desired_word)
      @char_map = {}
      @guess_list = []
      @current_limbs = 0
      self.target_word = desired_word if desired_word
    end

    def target_word=(target)
      @target_word = target
      map_target
    end

    def map_target
      index = 0
      target_word.each_char do |c|
        if char_map[c].is_a? Array
          char_map[c].push(index)
        else
          char_map[c] = [index]
        end
        index += 1
      end
    end

    def guess(character)
      return "Bad input man" unless valid?(character)
      return "You already guessed this, brah." if duplicate_guess?(character)
      self.guess_list << character
      exact_punishment if char_map[character].nil?
      char_map[character]
    end

    def current_state
      state = ''
      target_word.each_char do |c|
        if guess_list.include? c
          state += c.upcase
        else
          state += '_'
        end
      end
      state
    end

    def exact_punishment
      self.current_limbs += 1
    end

    def over?
      return true if won? or lost?
    end

    def lost?
      current_limbs >= max_limbs
    end

    def won?
      target_word.each_char do |c|
        return false unless guess_list.include? c
      end
    end

    def valid?(input)
      return false unless /\A[a-z]{1}\z/.match(input.downcase)
      true
    end

    def duplicate_guess?(input)
      guess_list.include? input
    end
end


game = HangmanGame.new('corn')
game.max_limbs = 8

# game.guess('c').each_with_index { |c,i| puts "#{i} : #{c}"}
# puts game.guess('z')

until game.over?
  puts game.guess(gets.chomp!)
  puts game.current_state
  # puts game.guess_list.join
end

if game.won?
  puts "You won!"
else
  puts "You suck."
end
