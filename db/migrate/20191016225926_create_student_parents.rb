class CreateStudentParents < ActiveRecord::Migration[6.0]
  def change
    create_table :student_parents do |t|
      t.integer :student_id
      t.integer :parent_id
    end
  end
end
