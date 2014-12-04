class AddEnablePointsToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :points_enabled, :boolean, default: true
  end
end
