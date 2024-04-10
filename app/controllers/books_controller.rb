class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  def search
    search_type = params[:search_type] 
    search_column = params[:search_column]
    search_value = params[:search_value] 
    
    case search_type
    when 'exact'
      @books = User.left_outer_joins(:books).ransack().result
      
      @books = Book..ransack({ search_column => search_value }).result
    when 'starts_with'
      @books = BooksUser.search_column.ransack("#{search_column}_start" => search_value).result
    when 'ends_with'
      @books = BooksUser.search_column.ransack("#{search_column}_end" => search_value).result
    when 'contains'
      @books = BooksUser.search_column.ransack("#{search_column}_cont" => search_value).result
    end 
    
    @book = Book.new
    render :index
  end 

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end 
  end 
end
