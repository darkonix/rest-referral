class AddRefereeIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :referee_id, :integer
    add_foreign_key :users, :users, column: :referee_id
  end
end
