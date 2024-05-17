class RemoveColumnActiveAndActiveDigestFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :active, :boolean
    remove_column :users, :active_digest, :string
  end
end
