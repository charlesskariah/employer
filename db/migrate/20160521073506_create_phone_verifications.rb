class CreatePhoneVerifications < ActiveRecord::Migration
  def change
    create_table :phone_verifications do |t|
      t.belongs_to :employer, index:true
      t.string :unique_token
      t.boolean :verified, :default => false

      t.timestamps null: false
    end
  end
end
