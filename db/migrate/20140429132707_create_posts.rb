class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :message
      t.text :picture
      t.text :link
      t.text :object_id
      t.text :large_image_url

      t.timestamps
    end
  end
end
