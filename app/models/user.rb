# coding: utf-8
class User < ActiveRecord::Base
  validates :name,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
            format: { with:VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }

  before_save :convert_to_lowercase

  def convert_to_lowercase
    email.downcase!
  end

  has_secure_password
end
