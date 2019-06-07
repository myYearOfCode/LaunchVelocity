class AddCurrentLapseToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :currentLapse, :integer
  end
end
