class User < ApplicationRecord
  has_many :todos
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
end
