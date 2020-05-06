require 'pry'
class Game < ActiveRecord::Base
    has_many :scores
	has_many :users, through: :scores

    #METHODS#
    attr_accessor :guesses_remaining, :answer_array, :won, :progress_answer
    attr_reader :num_guesses

        $the_answer = " "
        @@num_guesses = 10
        @@guesses_remaining = 10 
        @@answer_array = []
        @@progress_answer = ""

    def self.start_game
        current_game = Game.new
        current_game.round = Time.now
        current_game.won = false
        current_game.random_word
        current_game.make_board
        # current_game.word_board
        # current_game.make_guess
    end

    def make_guess
        if @guesses_remaining > 0
            puts "Enter a letter guess, your hint is ...."
            guess = gets.chomp
            if check_letter_guess(guess)

            end
        else
            game_lost
        end

    end

    def random_word
    words = ["git", "ruby", "orientation", "class", "instance", "method", "variable", "sql", "flatiron"]

        $the_answer = words.sample
    end

    def make_board
        @answer_array = $the_answer.split("")
        $the_answer.size.times do
            puts " _ "
        end
    end 

    def word_board
        puts @progress_answer.join
    end

    def check_letter_guess(input)
        @answer_array.each.with_index do |c, index| 
            if c == input
                @progress_answer[index] = input
            end
        end
        one_less_guess

    end 

    def game_lost
        if guesses_remaining == 0 
            response = PROMPT.ask("Awe too bad, the word was #{$the_answer}. Do you want to try again? y/n")
            if response == "y"
                start_game
            else
                # quit or exit
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
        puts "You have #{guesses_remaining} guesses left"
    end 

    def won
        won = true 
        # puts "Congratulations! You won and guessed #{$the_answer} correctly!"
    end 
    
    binding.pry

end 

