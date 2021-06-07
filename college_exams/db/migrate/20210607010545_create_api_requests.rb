class CreateApiRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :api_requests do |t|
      t.string :endpoint
      t.string :remote_ip
      t.json :payload
      t.datetime :created_at
    end
  end
end
