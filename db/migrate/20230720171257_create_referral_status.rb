class CreateReferralStatus < ActiveRecord::Migration[7.0]
  def change
    create_table :referral_statuses do |t|
      t.string :status
      t.text :description

      t.timestamps
    end
  end
end
