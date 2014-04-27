class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.string :username
      t.string :password
      t.string :sender
      t.string :to
      t.string :body

      t.timestamps
    end
  end
end
