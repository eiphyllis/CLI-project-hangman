class CreateScores < ActiveRecord::Migration[5.2]
    def change
        create_table :scores do |t|
            t.integer :score
            t.integer :user_id
            t.interger :game_id
        end 
    end 
end 