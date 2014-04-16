class Tournament < ActiveRecord::Base
	has_many :fixtures

	# Validations
    validates :name, presence: { message: 'Add Tournament Name' }
    validates :tourn_location, presence: { message: 'Add Tournament Location' }
end
