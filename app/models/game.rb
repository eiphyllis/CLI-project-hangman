require 'pry'
class Game < ActiveRecord::Base
    has_many :scores
	has_many :users, through: :scores

    #METHODS#
    attr_accessor :guesses_remaining, :answer_array, :progress_answer
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
    binding.pry

        $the_answer.size.times do
            @progress_answer.push(" _ ")
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
            response = PROMPT.ask("Awe too bad, the word was #{$the_answer}. Do you want to play again? y/n")
            if response == "y"
                # function for start game
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
    binding.pry
    

end 


def start
    puts " _    _"
    puts "| |  | |"
    puts "| |__| | __ _ _ __   __ _ _ __ ___   __ _ _ __"
    puts "|  __  |/ _` | '_ \\ / _` | '_ ` _ \\ / _` | '_ \\"
    puts "| |  | | (_| | | | | (_| | | | | | | (_| | | | |"
    puts "|_|  |_|\\__,_|_| |_|\\__, |_| |_| |_|\\__,_|_| |_|"
    puts "                     __/ |"
    puts "                    |___/"
    puts "\n" 
    # method that calls everything else
    # welcome message
    # new instance of game with num_guesses and guesses_remaining fresh
        # generate random word
        # save that word as the answer
        # answer_array = split that answer so we have something to iterate/compare
        # create progress_array that replaces all the chars in answer_array with _
        # print progress_array and guesses_remaining left to terminal
    # print direction to ask for a letter guess
        # user enters letter guess
        # check their input against the answer_array
            #if found, 
                # say "getting closer"
                #  "reveal" that index in the progress_array
            #if not found, say "nope"
        # decrement guesses_remaining
        # print progress_array


end
