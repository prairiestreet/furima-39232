class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :last_name_full_width, :first_name_full_width,
            :last_name_full_width_katakana, :first_name_full_width_katakana, :birthday, presence: true
  validates :last_name_full_width_katakana, :first_name_full_width_katakana,
            format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :last_name_full_width, :first_name_full_width,
            format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers'

  has_many :items
  has_many :purchase_records
end
