class AddFavoriteToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :favorite, :boolean, default: false, required: true
  end
end
