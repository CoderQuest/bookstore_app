class AuthorsController < ApplicationController
	before_action :set_author, except: [:index, :new, :create]  # DRY

	def index
	end

	def show
		# require 'pry'; binding.pry
	end

	def new 
		@author = Author.new
	end

	def create
		@author = Author.new(author_params)
		if @author.save
			flash[:success] = "Author has been created"
			redirect_to @author  # or author_path(@author), they're the same thing,  pointing to the show action
		else										# redirect basically points to the action and followed by rendering of the templategit a
			flash[:danger] = "Author has not been created"
			render :new # or 'new', they work the same. this only renders the new template. It doesn't point to the new action
		end		
	end

	def edit

	end

	def update
		if @author.update(author_params)
			flash[:success] = "Author has been updated"
			redirect_to @author
		else
			flash[:danger] = "Author has not been updated"
			render :edit
		end
	end

	def destroy
		@author.destroy
		flash[:success] = "Author has been deleted"
		redirect_to authors_path
	end

private 

	def author_params
		params.require(:author).permit(:first_name, :last_name)
	end

	def set_author
		@author = Author.find(params[:id])
	end
end