class BookCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]
  
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_back(fallback_location: books_path)
  end 
  
  def destroy
    BookComment.find(params[:id]).destroy
    redirect_back(fallback_location: books_path)
  end 
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end 
  
  def ensure_correct_user
    comment = BookComment.find(params[:id])
    unless comment.user == current_user
      redirect_to book_path(comment.book)
    end
  end
end
