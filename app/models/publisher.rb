class Publisher < ActiveRecord::Base
	validates :name, presence: true
	validates :name, uniqueness: {case_sensitive: false} # Add uniqueness and turns of case sensitivity
end
