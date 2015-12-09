require "rails_helper" 	# in rspec version 3, use rails_helper instead of rspec_helper

RSpec.describe Author, :type => :model do 
	it "requires a first name" do 
		author = Fabricate.build(:author, first_name: nil)

		expect(author).not_to be_valid
		expect(author.errors[:first_name].any?).to be_truthy
	end

	it "requires a last name" do 
		author = Fabricate.build(:author, last_name: nil)
		#require 'pry'; binding.pry  use this line to examin errors

		expect(author).not_to be_valid
		expect(author.errors[:last_name].any?).to be_truthy
	end

	describe "#full_name" do	# hash(#) stands for an instance method 
		it "returns the full name of the author" do 
			author = Fabricate(:author, first_name: 'Yi', last_name: 'Ren')

			expect(author.full_name).to eq("Yi Ren")
		end
	end
end