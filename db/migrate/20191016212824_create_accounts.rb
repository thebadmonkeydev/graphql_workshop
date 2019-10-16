class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :email, null: false
      t.string :first_name
      t.string :last_name

      t.references :user, polymorphic: true

      t.timestamps null: false
    end
  end
end
