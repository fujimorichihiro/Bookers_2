class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# ヴァリデーションチェック----------------------------------------------------
  validates :name, length: { minimum: 2 }
  validates :name, length: { maximum: 20 }
  validates :introduction, length: { maximum: 50 }

# Modelの関連付け-------------------------------------------------------
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
#メソッド------------------------------------------------------------------
  #follow関連のメソッド-----------------------------------
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  # searchメソッド------------------------------------------
  def User.search(search, table, option)
    if option == "1"
      User.where(name: "#{search}")
    elsif option == "2"
      User.where('name LIKE ?',"%#{search}%")
    elsif option == "3"
      User.where('name LIKE ?',"#{search}%")
    elsif option == "4"
      User.where('name LIKE ?',"%#{search}")
    else
      User.all
    end
  end
  # JP prefecture用メソッド-----------------------------------
  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  #geocoder用-------------------------------------------------
  #config/initialize/geocoder.rbで設定。
  #住所が詳しすぎるとgeocoderがうまくいかない。

  def current_position
    #現在地を返す？
  end
  #住所のカラムを連結する
  def user_address
    [self.prefecture_name, self.address_city, self.address_street, self.address_building].compact.join
  end

  geocoded_by :user_address#, latitude: :lat, longitude: :lon
  after_validation :geocode

end
