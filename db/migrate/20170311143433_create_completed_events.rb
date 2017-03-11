class CreateCompletedEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :completed_events do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :event, foreign_key: true

      t.timestamps
    end
    add_index :completed_events, [:user_id, :event_id]
  end
end
