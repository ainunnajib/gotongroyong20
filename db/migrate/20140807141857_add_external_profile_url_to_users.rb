class AddExternalProfileUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :external_profile_url, :string
  end
end
