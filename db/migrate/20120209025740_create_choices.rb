class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.references :question
      t.references :survey
      t.string :content, :null => false

      t.timestamps
    end
  end
end
