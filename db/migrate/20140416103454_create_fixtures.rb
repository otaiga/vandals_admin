class CreateFixtures < ActiveRecord::Migration
  def change
    create_table :fixtures do |t|
      t.string :home_team
      t.string :away_team
      t.time :kickoff_time
      t.integer :tournament_id
      t.integer :home_score_result
      t.integer :away_score_result

      t.timestamps
    end
  end
end
