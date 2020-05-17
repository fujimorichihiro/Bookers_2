class Book < ApplicationRecord

# Validation
    validates :title, presence: true
    validates :body, presence: true
    validates :body, length: { maximum: 200 }
# Modelの関連付け
	belongs_to :user

	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
end
