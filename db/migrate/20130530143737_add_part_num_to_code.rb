class AddPartNumToCode < ActiveRecord::Migration
  def change
    add_column :codes, :partNum, :string
    add_column :codes, :footprint, :string
    add_column :codes, :manufacturer, :string
    add_column :codes, :describe, :text
  end
end
