class Course < ApplicationRecord
  has_many :la_courses, dependent: :destroy
  has_many :la_details, through: :la_courses
end
