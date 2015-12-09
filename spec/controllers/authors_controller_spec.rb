require 'rails_helper'

RSpec.describe AuthorsController, :type => :controller do 
	describe "GET #index" do 
		it "returns a successful http request status code" do
			get :index  #getting a response

			expect(response).to have_http_status(:success)
		end
	end

	describe "GET #show" do
		it "returns a successful http request status code" do
			author = Fabricate(:author)

			get :show, id: author.id 			# Id is need here because otherwise rspec won't know which author to pull up.
			expect(response).to have_http_status(:success)
		end
	end
end