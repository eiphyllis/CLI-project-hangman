

class Score < ActiveRecord::Base
    belongs_to :user
    belongs_to :game
    
    #METHODS#
    def self.top_scores
        # Score.all.order(:score).limit(3).each.with_index do |score, index|
            # User.joins(:scores)
            # "SELECT user.name FROM users INNER JOIN scores ON user.id = scores.user_id"
        # end

        sorted_scores = (Score.all.sort! do |a, b| 
            a.score <=> b.score
        end)

        top = []
        top << sorted_scores[0..2]
        top 
    end
end 