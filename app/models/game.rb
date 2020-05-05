require 'pry'
class Game < ActiveRecord::Base
    has_many :scores
	has_many :users, through: :scores

    #METHODS#
    attr_accessor :guesses_remaining, :answer_array
    attr_reader :num_guesses

    $the_answer = " "
    @num_guesses = 10
    @guesses_remaining = 10 
    @answer_array = $the_answer.split("")
    @progress_answer = []

    def random_word
    words = ["git", "ruby", "orientation", "class", "instance", "method", "variable", "sql", "flatiron"]

        $the_answer = words.sample
    end

    def make_board
        $the_answer.size.times do
            @progress_answer << " _ "
        end
    end 

    def word_board
        puts @progress_answer.join
    end

    def check_letter_guess(input)
        @answer_array.each_with_index do |c, index| 
            if c == input
                @progress_answer[index] = input
            end
        end
        one_less_guess

    end 

    def game_lost
        if guesses_remaining == 0 
            response = PROMPT.ask("Awe too bad, do you want to try again? y/n")
                if response == "y"
                    # function for start game
                else
                    # quit or exit
                end
            end
        end
    end 

    def check_word_guess(input)
        if $the_answer == input.strip
            won 
        end 
    end 

    def one_less_guess
        guesses_remaining -= 1 
    end 

    def won
        won = true 
        # puts "Congratulations! You won and guessed #{$the_answer} correctly!"
    end 
    
    binding.pry

end 