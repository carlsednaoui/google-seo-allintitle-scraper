class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :word
      t.integer :allintitle

      t.timestamps
    end
  end
end
