class CreateReferrals < ActiveRecord::Migration[6.1]
  def change
    create_table :referrals do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :code
      t.integer :signups

      t.timestamps
    end
  end
end
