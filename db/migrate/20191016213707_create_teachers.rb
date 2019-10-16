class CreateTeachers < ActiveRecord::Migration[6.0]
  def change
    create_table :teachers do |t|
      t.integer :grade
      t.string :title
    end
  end
end
