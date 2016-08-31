class AddDefaultValueToSupportRequests < ActiveRecord::Migration[5.0]
  def change
    change_column_default :support_requests, :status, false
  end
end
