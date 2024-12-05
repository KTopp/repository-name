class AddQrCodeToTicket < ActiveRecord::Migration[7.2]
  def change
    add_column :tickets, :qr_code, :string
  end
end
