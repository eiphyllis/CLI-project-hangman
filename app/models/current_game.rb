#!/usr/bin/env ruby
require_relative '../config/environment'
# require '../app/current_game.rb'
require 'pry'
    #METHODS#
    $count = 0
    $the_answer = " "

    $num_guesses = 10
    $guesses_remaining = 10 
    $answer_array = []
    $progress_answer = []
    def reset_game
        $guesses_remaining = 10 
        $answer_array = []
        $progress_answer = []
    end 
        
    $prompt = TTY::Prompt.new
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
        puts "Welcome to hangman!" # welcome message
        menu 
        game_play
    end

    def menu
        category = $prompt.select("Choose a new game or scoreboard from the menu", %w(New Scoreboard My games Help Quit))
        if category == "New"
                user_name = $prompt.ask("What is your name?")
                
                if find_user(user_name)
                    current_game = Game.create
                    new_score = Score.create
                    new_score.game_id = current_game.id
                    new_score.user_id = find_user(user_name).id
                else
                    new_user = User.create
                    new_user.name = user_name
                    new_user.save
                    save_this_game(new_user)
                end 
                new_game
                
                # game_won
            
        
        elsif category == "Scoreboard"
                # THIS IS UNDEFINED: method for listing top games
        elsif category == "My games"
            # THIS IS UNDEFINED: method for listing user's games
        elsif category == "Help"
            print "instructions" # THIS IS NEEDS TO BE EDITED
        else
            exit
        end
    end

    def game_play
        while !game_over
            make_letter_guess
        end
    end 


    def ask_name
        user_name = $prompt.ask("What is your name?")
        
        if find_user(user_name)
            save_this_game(find_user(user_name))
        else
            new_user = User.create
            new_user.name = user_name
            new_user.save
            save_this_game(new_user)
        end 
    end

    def find_user(user_name)
        User.find_by_name(user_name)
    end

    def save_this_game(this_user)
        $current_game = Game.create
        new_score = Score.create
        new_score.game_id = $current_game.id
        new_score.user_id = this_user.id
    end 

    def new_game
        random_word
        make_board
        word_board
        while !game_over
            make_letter_guess
        end

        if $progress_answer == $answer_array
            game_won 
        else 
            game_lost #may need reset function in order to work
            # binding.pry
        end 
        menu 
        # puts "Thanks for playing our CLI Hangman! Come back again soon." 
    end

    def random_word
    words = ["ruby"]
    # "git", "ruby", "orientation", "class", "instance", "method", "variable", "sql", "flatiron"
        $the_answer = words.sample
    end

    def make_board
        $answer_array = $the_answer.split("")
        $the_answer.size.times do
            $progress_answer.push(" _ ")
        end
    end 

    def move_to_next_round
        one_less_guess
        word_board
    end 

    def one_less_guess
        $guesses_remaining -= 1 
        puts "You have #{$guesses_remaining} guess(es) left"
    end

    def word_board
        puts $progress_answer.join
    end

    def make_letter_guess
            puts "Enter a letter guess:"
            guess = gets.chomp
            if guess == "exit"
                exit
            elsif check_letter_guess(guess)
                if $progress_answer == $answer_array
                    # game_won
                else 
                    puts "Good guess!"
                    move_to_next_round
                end 
            else
                puts "Sorry, wrong guess :(" 
                move_to_next_round
            end
        if !game_over
         want_word_guess
        end 
    end

    def want_word_guess
        response = $prompt.ask("Do you want to guess the whole word? y/n")
            if response == "exit"
                exit
            elsif response == 'y'
                 make_word_guess
            end 
    end 

    def make_word_guess
            puts "What do you think the word is?"
            guess = gets.chomp
            if guess == "exit"
                exit
            elsif check_word_guess(guess)
                # game_won
            else
                puts "Survey says? ... No."
            end
            
    end 

    def check_letter_guess(input)
        $progress_answer.each_with_index do |c, index|
            if $answer_array[index] == input
            $progress_answer[index] = input
            end
        end
        return false
    end 

    def check_word_guess(input)
        if $the_answer == input.strip
            $progress_answer = $answer_array
            return true 
        end 
        return false 
    end 

    def game_over
        if ($progress_answer == $answer_array) || ($guesses_remaining == 0)
            return true 
        else 
            return false 
        end 
    end

    def game_lost
        # $current_game.won = false 
        response = $prompt.ask("Awe too bad, the word was #{$the_answer}. Do you want to play again? y/n")
        if response == "y"
            reset_game
            new_game
        end
        # binding.pry
    end 

    def game_won
        puts "WOW! You got it!"
        # $current_game.won = true 
        # $current_game.class.save 
        # # Score.find($current_game.id).score = 10
        # Score.all.find do |score|
        #     score.game_id == $current_game.id
        # end.score = 10
        
        response = $prompt.ask("Congratulations! You won and guessed #{$the_answer} correctly! Do you want to play again? y/n")
        if response == "y"
            new_game
        end
    end 
start
puts "HELLO WORLD"
