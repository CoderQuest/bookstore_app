require 'rails_helper'

RSpec.describe Book, :type => :model do
	it {should belong_to(:publisher)}
	it {should have_many(:publications)}

	it {should validate_presence_of(:title)}
	it {should validate_presence_of(:isbn)}
	it {should validate_presence_of(:description)}
	it {should validate_presence_of(:published_at)}
	it {should validate_presence_of(:publisher_id)}
	it {should validate_numericality_of(:page_count).only_integer} # this means it should be a number 
	it {should validate_numericality_of(:price).is_greater_than_or_equal_to(0.0)}  # the book can be any price or for free
end