class BooksController < ApplicationController
  before_action :authenticate_user!
  def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
		   flash[:notice] = "You have created book successfully."
		   redirect_to book_path(@book)
		else
		   @user = current_user
		   @books = Book.all
		   render :index
		end
	end
# 投稿一覧
	def index
		@user = current_user
		@book = Book.new
		@books = Book.all
	end
# 
	def show
		@book = Book.new
		@books = Book.find(params[:id])
		@user = User.find(@books.user_id) #数字が入ればよい！
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
		   flash[:notice] = "You have update book successfully."
		   redirect_to user_path(current_user)
		else
			render :edit
		end

	end

	def destroy
		book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
