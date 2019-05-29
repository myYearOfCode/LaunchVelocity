class AddGraphToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :graph, :text
  end
end
