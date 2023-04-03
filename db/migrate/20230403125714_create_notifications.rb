class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.belongs_to :notifiable, polymorphic: true
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :notifications, %i[notifiable_id notifiable_type]
  end
end
