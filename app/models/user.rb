class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :last_name_full_width, :first_name_full_width, 
            :last_name_full_width_katakana, :first_name_full_width_katakana, :birthday, presence: true
end