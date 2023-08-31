class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :last_name_full_width, :first_name_full_width, 
            :last_name_full_width_katakana, :first_name_full_width_katakana, :birthday, presence: true
  validates :last_name_full_width_katakana, :first_name_full_width_katakana, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: "is invalid. Input full-width katakana characters" }
  validates :last_name_full_width, :first_name_full_width, format: { with: /\A[\p{hiragana}\p{katakana}\p{blank}ー－]+\z/, message: "is invalid. Input full-width characters" }
  validate :password_complexity

  private

  def password_complexity
    return if password.blank? || (password =~ /[a-zA-Z]/ && password =~ /[0-9]/)
    errors.add :password, 'is invalid. Include both letters and numbers'
  end
end