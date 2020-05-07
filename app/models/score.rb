

class Score < ActiveRecord::Base
    belongs_to :user
    belongs_to :game
    
    #METHODS#
    def self.top_scores
        # Score.order(score: :acs).limit(5).each.with_index do |score, index|
            # User.joins(:scores)
            # "SELECT user.name FROM users INNER JOIN scores ON user.id = scores.user_id"
        # end
        
        # User.select(:name, SUM(:score)).joins(:scores).group_by(users.id)
        Score.group(:user_id).select('SUM(score) as total').order('total desc')
        binding.pry
        # db.execute("SELECT users.name, SUM(scores.score) FROM users JOIN scores ON users.id = scores.user_id ORDER BY SUM(scores.score)")
        
    #     sorted_scores = (Score.all.sort! do |a, b| 
    #         a.score <=> b.score
    #     end)
    #     top = []
    #     top << sorted_scores[0..2]
    #     top 
    end
end 