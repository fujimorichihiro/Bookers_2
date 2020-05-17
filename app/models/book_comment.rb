class BookComment < ApplicationRecord
	validates :comment, presence: true
# Modelの関連付け
	belongs_to :user
	belongs_to :book
end
