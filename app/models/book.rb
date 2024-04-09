class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length:{maximum:200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end 
  
  def self.search(query)
    if query.present?
      results = Book.ransack(attribute_title_cont: query).result(distinct: true)
    end
    results
  end
end
