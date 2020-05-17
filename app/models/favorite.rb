class Favorite < ApplicationRecord
# Modelの関連付け
	belongs_to :user
	belongs_to :book
end
