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

	describe "GET #edit" do 		#since we're fetching from the database, we should use let form instead of it form
		let(:author) {Fabricate(:author)}
		it "sends a successful edit request" do
			get :edit, id: author   									# 'author' here is referring to the author from let(:author) from the top
			expect(response).to have_http_status(:success) #in edit, we are forwarding a puts request
		end
	end

	describe "PUT #update" do
		context "successful update" do
			let(:john) {Fabricate(:author, first_name: "John")}

			it "updates the modified author object" do 																									#we need john.id in this case because we need to tell the database which object we want to change
				put :update, author: Fabricate.attributes_for(:author, first_name: "Mike"), id: john.id 	#updating the data from the form, use put.

				expect(Author.last.first_name).to eq("Mike")
				expect(Author.last.first_name).not_to eq("John")
			end

			it "sets the success flash message" do 
				put :update, author: Fabricate.attributes_for(:author, first_name: "Mike"), id: john.id
				expect(flash[:success]).to eq("Author has been updated")
			end
			it "redirects to the show action" do
				put :update, author: Fabricate.attributes_for(:author, first_name: "Mike"), id: john.id
				expect(response).to redirect_to(author_path(Author.last))
			end
		end

		context "unsuccessful update" do 
			let(:john) {Fabricate(:author, first_name: "John")}

			it "does not update the author object with invalid inputs" do 																									#we need john.id in this case because we need to tell the database which object we want to change
				put :update, author: Fabricate.attributes_for(:author, first_name: nil), id: john.id 	#updating the data from the form, use put.

				expect(Author.last.first_name).to eq("John")
			end

			it "sets the failure danger flash message" do 
				put :update, author: Fabricate.attributes_for(:author, first_name: nil), id: john.id
				expect(flash[:danger]).to eq("Author has not been updated")
			end
		end
	end
end