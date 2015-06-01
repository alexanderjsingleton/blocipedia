class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.integer :wiki_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
