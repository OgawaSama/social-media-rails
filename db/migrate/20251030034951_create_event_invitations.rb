class CreateEventInvitations < ActiveRecord::Migration[8.1]
  def change
    create_table :event_invitations do |t|
      t.references :event, null: false, foreign_key: true
      t.references :invitee, polymorphic: true, null: false
      t.integer :status

      t.timestamps
    end
  end
end
