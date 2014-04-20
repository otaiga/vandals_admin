class AddAttachmentPhotoToGalleryImages < ActiveRecord::Migration
  def self.up
    change_table :gallery_images do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :gallery_images, :photo
  end
end
