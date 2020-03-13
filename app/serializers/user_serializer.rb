class UserSerializer < ActiveModel::Serializer
  attributes :id, :fname, :lname, :email, :username, :birthday
  has_one :user_type
end
