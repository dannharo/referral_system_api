class CreateReferralComments < ActiveRecord::Migration[7.0]
  def change
    create_table :referral_comments do |t|
      t.references :referral, null: false, foreign_key: true
      t.references :referral_status, null: false, foreign_key: true
      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.text :comment
      t.string :created_by_name

      t.timestamps
    end
  end
end
