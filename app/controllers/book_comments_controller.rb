class BookCommentsController < ApplicationController
# もっと短く書けないかメンターに聞く。どのデータが使えるかなど
  def create
  	@showbook = Book.find(params[:book_id])
  	@book_comment = BookComment.new(book_comment_params)
  	@book_comment.user_id = current_user.id
  	@book_comment.book_id = @showbook.id
  	@book_comment.save
  	render 'create'
  end

  def destroy
  	# book = Book.find(params[:book_id])
  	# book_comment = current_user.book_comments.find_by(book_id: book.id)
  	@book_comment = BookComment.find(params[:id])
    @book_comment.destroy
  	render 'destroy'
  end

  private

  def book_comment_params
  	params.require(:book_comment).permit(:comment, :user_id, :book_id)
  end

end


