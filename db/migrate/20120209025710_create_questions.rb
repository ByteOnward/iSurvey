class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :survey
      t.string :title, :null => false
      t.integer :question_type, :default => 0
      #single choices => 0

      t.timestamps
    end
  end
end
