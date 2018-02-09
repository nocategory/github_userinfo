class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :login
      t.string :name
      t.string :avatar_url
      t.integer :followers
      t.integer :public_repos
      t.string :repos_url

      t.timestamps
    end
  end
end
