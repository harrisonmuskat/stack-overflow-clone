class RemoveUserIdFromQuestions < ActiveRecord::Migration[5.0]
  def up
    remove_column :questions, :user_id
  end
  def down
    change_table :questions do |t|
      t.belongs_to :user
    end
  end
end
