class CreateBusinessRelationships < ActiveRecord::Migration[8.1]
  def change
    create_table :business_relationships do |t|
      t.references :follower, polymorphic: true, null: false
      t.references :followed, polymorphic: true, null: false

      t.timestamps
    end

    add_index :business_relationships, 
              [:follower_id, :follower_type, :followed_id, :followed_type], 
              unique: true, 
              name: 'index_business_relationships_on_follower_and_followed'
    add_index :business_relationships, 
              [:followed_id, :followed_type]
  end
end