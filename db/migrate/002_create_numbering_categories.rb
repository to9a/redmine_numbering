class CreateNumberingCategories < ActiveRecord::Migration
  def change
    create_table :numbering_categories do |t|
      t.string :identifier
      t.string :disp_name
    end
  end
end
