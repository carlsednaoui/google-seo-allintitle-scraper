class RemoveAllintitleFromKeywords < ActiveRecord::Migration
  def change
    remove_column :keywords, :allintitle
  end
end
