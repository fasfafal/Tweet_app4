class RenameConetentColumnToPosts < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :conetent, :content
  end
end
