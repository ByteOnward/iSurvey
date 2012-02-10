class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.references :user
      t.string :name, :null => false
      t.string :desc
      t.integer :status, :default => 0

      t.timestamps
    end
    add_index :surveys, [:name, :desc], :unique => true
  end
end
