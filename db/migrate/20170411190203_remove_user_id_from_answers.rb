class RemoveUserIdFromAnswers < ActiveRecord::Migration[5.0]
  def up
    remove_column :answers, :user_id
  end
  def down
    change_table :answers do |t|
      t.belongs_to :user
    end
  end
end
