class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :message
      t.text :picture
      t.text :link
      t.text :object_id
      t.text :large_image_url
      t.text :description
      t.text :video_url
      t.datetime :created_time

      t.timestamps
    end
  end
end
