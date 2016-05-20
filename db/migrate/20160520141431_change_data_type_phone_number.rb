class ChangeDataTypePhoneNumber < ActiveRecord::Migration
  def change
    change_column(:employers, :phone_number, :string)
  end
end
