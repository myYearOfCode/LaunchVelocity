class AddLinkedinToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :linkedInUrl, :string
  end
end
