class AddCountersToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :competition, :integer, required: true, default: 0
    add_column :keywords, :r_value, :decimal, required: true, default: BigDecimal.new("0.0")
  end
end
