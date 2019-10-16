class CreateParents < ActiveRecord::Migration[6.0]
  def change
    create_table :parents do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone

      t.timestamps null: false
    end
  end
end
