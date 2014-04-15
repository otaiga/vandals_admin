class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.date :tourn_date
      t.string :tourn_location

      t.timestamps
    end
  end
end
