class SearchesController < ApplicationController
  
  def index
    @search_type = params[:search_type] 
    search_value = params[:search_value] 
  
    case @search_type
    when 'exact'
      @users = User.where(attribute: search_value)
      @books = Book.where(attribute: search_value)
    when 'starts_with'
      @users = User.where('attribute LIKE ?', "#{search_value}%")
      @books = Book.where('attribute LIKE ?', "#{search_value}%")
    when 'ends_with'
      @users = User.where('attribute LIKE ?', "%#{search_value}")
      @books = Book.where('attribute LIKE ?', "%#{search_value}")
    when 'contains'
      @users = User.where('attribute LIKE ?', "%#{search_value}%")
      @books = Book.where('attribute LIKE ?', "%#{search_value}%")
    end 
    
  end
  
end 
