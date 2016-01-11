class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { maximum: 32 }
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password
end
