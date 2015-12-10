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

	describe "GET #new" do
		it "returns a successful http request status code" do
			get :new
			expect(response).to have_http_status(:success)
		end
	end

	#sending data to the server, use post request
	describe "POST #create" do 
		context "a sucessful create" do
			it "saves the new author object" do
				post :create, author: Fabricate.attributes_for(:author) # use fabricate to create an author object in the server

				expect(Author.count).to eq(1)
			end

			it "redirects to the author show action" do
				post :create, author: Fabricate.attributes_for(:author)

				expect(response).to redirect_to author_path(Author.last)
			end

			it "sets the success flash message" do
				post :create, author: Fabricate.attributes_for(:author)

				expect(flash[:success]).to eq("Author has been created")
			end
		end

		context "a unsucessful create" do 
			it "does not save the author object with invalid inputs" do 
				post :create, author: Fabricate.attributes_for(:author, first_name: nil)

				expect(Author.count).to eq(0)
			end
			#since the default behavior of the rails for when create fails, it just rerenders, so we don't need to test how the page handles fails
			it "sets the unsucessful flash message" do 
				post :create, author: Fabricate.attributes_for(:author, first_name: nil)

				expect(flash[:danger]).to eq("Author has not been created")
			end
		end
	end
end