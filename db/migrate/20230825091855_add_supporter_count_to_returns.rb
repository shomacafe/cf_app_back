class AddSupporterCountToReturns < ActiveRecord::Migration[7.0]
  def change
    add_column :returns, :supporter_count, :integer, default: 0, comment: "リターンのサポーター数"
  end
end
