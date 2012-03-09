class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :survey_id

      t.timestamps
    end

    add_index :comments, [:user_id, :survey_id]
  end
end
