require 'pry'
class Game < ActiveRecord::Base
    has_many :scores
	has_many :users, through: :scores

    def self.game_lost
        # Game.won = false 
        response = $prompt.yes?("Awe too bad, the word was #{$the_answer}. Do you want to play again? y/n")
        if response == "y"
            new_game
        else
            exit
        end
    end 
    
    def self.game_won
        # Game.won = true 
        # Score.all.find do |score|
        #     score.game_id == self.id
        # end.score = 10
        
        response = $prompt.yes?("Congratulations! You won and guessed #{$the_answer} correctly! Do you want to play again? y/n")
        if response == "y"
            new_game
        else
            exit
        end
    end 
    
end 