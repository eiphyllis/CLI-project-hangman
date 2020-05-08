class Score < ActiveRecord::Base
    belongs_to :user
    belongs_to :game
    
    #METHODS#
    def self.top_scores
        highest = ActiveRecord::Base.connection.execute("SELECT users.name, SUM(scores.score) FROM users JOIN scores ON users.id = scores.user_id GROUP BY user_id ORDER BY SUM(scores.score) DESC LIMIT 3")
        puts "Players      Scores"
        highest.map do |win|
            puts "#{win["name"]}        #{win["SUM(scores.score)"]}"
        end 
    end
end 