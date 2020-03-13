class UserType < ApplicationRecord
  has_many :user
  validates :name ,presence: true
  validates_uniqueness_of :name
end
