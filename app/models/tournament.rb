class Tournament < ActiveRecord::Base
	has_many :fixtures
	has_one :gallery
	has_many :gallery_images, :through => :gallery

	# Validations
    validates :name, presence: { message: 'Add Tournament Name' }
    validates :tourn_location, presence: { message: 'Add Tournament Location' }
end
