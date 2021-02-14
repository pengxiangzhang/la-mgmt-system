class CreateLaCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :la_courses do |t|
      t.belongs_to :la_detail, :foreign_key => "la_detail_id"
      t.belongs_to :course, :foreign_key => "course_id"
      t.timestamps
    end
  end
end
