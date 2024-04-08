class SearchesController < ApplicationController
  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).includes(:title)
  end 
end
