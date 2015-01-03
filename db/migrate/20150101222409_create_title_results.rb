class CreateTitleResults < ActiveRecord::Migration
  def change
    create_table :title_results do |t|
      t.integer :keyword_id
      t.integer :google_count

      t.timestamps null: false
    end
  end
end
