class User < ApplicationRecord
  authenticates_with_sorcery!
  include ActiveModel::Validations

  belongs_to :type, class_name: 'UserType'

  validates :username ,presence:true ,length: { minimum: 3 , maximum: 25}


  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,length:{maximum:105},
            format: {with: VALID_EMAIL_REGEX}
  validates_uniqueness_of :email, conditions: -> { where(active:true) }
  validates_uniqueness_of :username, conditions: -> { where(active:true) }

  validate :validate_age

  private

  def validate_age
    if birthday.present? && birthday < 100.years.ago.to_date
      errors.add(:birthday, 'You should be over 18 years old.')
    end
  end

end
