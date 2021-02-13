class LaDetail < ApplicationRecord
  belongs_to :user_detail
  has_many :la_courses
  has_many :courses, through: :la_courses, dependent: :destroy
end
