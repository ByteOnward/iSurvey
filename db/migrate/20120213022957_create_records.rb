class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :statistics
      t.references :survey
      t.references :question
      t.references :choice
      t.references :user
      
      
      t.timestamps
    end
  end
end
