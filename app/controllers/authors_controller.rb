class AuthorsController < ApplicationController

	def index
	end

	def show
		# require 'pry'; binding.pry
		@author = Author.find(params[:id])
	end

	def new 
		@author = Author.new
	end

	def create
		@author = Author.new(author_params)
		if @author.save
			flash[:success] = "Author has been created"
			redirect_to @author  # or author_path(@author), they're the same thing,  pointing to the show action
		else										# redirect basically points to the action and followed by rendering of the template
			flash[:danger] = "Author has not been created"
			render :new # or 'new', they work the same. this only renders the new template. It doesn't point to the new action
		end		
	end

private 

	def author_params
		params.require(:author).permit(:first_name, :last_name)
	end

end