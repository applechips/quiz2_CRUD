class CreateSupportRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :support_requests do |t|
      t.string :name
      t.string :email
      t.string :department
      t.text :message
      t.boolean :status

      t.timestamps
    end
  end
end
