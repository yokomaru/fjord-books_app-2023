class AddZipcodeAndAdressAndIntoroductionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :address, :string, limit: 200
    add_column :users, :introduction, :text, limit: 1000
    add_column :users, :zipcode, :string, limit: 7
  end
end
