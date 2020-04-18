class AddReceiverIdToShares < ActiveRecord::Migration[6.0]
  def change
    add_column :shares, :receiver_id, :integer
  end
end
