class BookCommentsController < ApplicationController

  def create
  	@showbook = Book.find(params[:book_id])
  	@book_comment = BookComment.new(book_comment_params)
  	@book_comment.user_id = current_user.id
  	@book_comment.book_id = @showbook.id
  	if @book_comment.save
  		redirect_to book_path(@showbook)
  	else
  		@book = Book.new
  		@user = User.find(@showbook.user_id)
  	    render 'books/show'
  	end
  end

  def destroy
  	book = Book.find(params[:book_id])
  	book_comment = current_user.book_comments.find_by(book_id: book.id)
  	book_comment.destroy
  	redirect_to book_path(book)
  end

  private

  def book_comment_params
  	params.require(:book_comment).permit(:comment)
  end

end
