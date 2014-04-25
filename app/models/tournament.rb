class Tournament < ActiveRecord::Base
	has_many :fixtures, dependent: :destroy
	has_one :gallery, dependent: :destroy
	has_many :gallery_images, :through => :gallery, dependent: :destroy

	# Validations
    validates :name, presence: { message: 'Add Tournament Name' }
    validates :tourn_location, presence: { message: 'Add Tournament Location' }
end
