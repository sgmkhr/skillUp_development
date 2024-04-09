class SearchesController < ApplicationController
  
  def search
    @q = params[:q]
    @books = Book.ransack(title_cont: @q).result
    @users = User.ransack(name_cont: @q).result
    render :index
  end 
  
  
  def index
  end 
  
end
