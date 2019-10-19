class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :student_id

      t.references :sender, polymorphic: true

      t.timestamps null: false
    end
  end
end
