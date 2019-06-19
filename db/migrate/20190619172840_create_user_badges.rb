class CreateUserBadges < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_badges, :string
  end
end