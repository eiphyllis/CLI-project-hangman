class CreateGames < ActiveRecord::Migration[5.2]
    def change
        create_table :games do |t|
            t.datetime :round
            t.boolean :won
        end 
    end 
end 