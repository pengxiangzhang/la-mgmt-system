class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :course_name, unique: true
      # t.string :slack
      # TODO: Slack per course
      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
