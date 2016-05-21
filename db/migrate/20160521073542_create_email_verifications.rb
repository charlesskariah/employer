class CreateEmailVerifications < ActiveRecord::Migration
  def change
    create_table :email_verifications do |t|
      t.belongs_to :employer, index:true
      t.string :unique_token
      t.boolean :verified, :default => false

      t.timestamps null: false
    end
  end
end
