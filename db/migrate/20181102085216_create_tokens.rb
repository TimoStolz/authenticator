class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :alg
      t.string :key
      t.datetime :exp
      t.datetime :nbf
      t.uuid :user_id, index: true, foreign_key: { to_table: :users }
      t.jsonb :other_payload
      t.timestamps
    end
  end
end
