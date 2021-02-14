class LaDetail < ApplicationRecord
  belongs_to :user_detail
  has_many :la_courses, dependent: :destroy
  has_many :courses, through: :la_courses
end
