class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# ヴァリデーションチェック
  validates :name, length: { minimum: 2 }
  validates :name, length: { maximum: 20 }
  validates :introduction, length: { maximum: 50 }

# Modelの関連付け
  has_many :books, dependent: :destroy
  has_many :book_commemts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image
end
