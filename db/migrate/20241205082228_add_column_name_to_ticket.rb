class AddColumnNameToTicket < ActiveRecord::Migration[7.2]
  def change
    add_column :tickets, :buyer_id, :integer
  end
end
