class Book < ApplicationRecord

# Validation
    validates :title, presence: true
    validates :body, presence: true
    validates :body, length: { maximum: 200 }
# Modelの関連付け
	belongs_to :user

	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def Book.search(search, table, option)
		if option == "1"
           Book.where(title: "#{search}")
        elsif option == "2"
           Book.where('title LIKE ?',"%#{search}%")
        elsif option == "3"
           Book.where('title LIKE ?',"#{search}%")
        elsif option == "4"
           Book.where('title LIKE ?',"%#{search}")
        else
           Book.all
        end
    end
end
