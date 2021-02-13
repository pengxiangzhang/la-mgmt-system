class Course < ApplicationRecord
  has_many :la_courses
  has_many :la_details, through: :la_courses, dependent: :destroy
end
