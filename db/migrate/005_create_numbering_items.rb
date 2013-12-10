class CreateNumberingItems < ActiveRecord::Migration
  def change
    create_table :numbering_items do |t|
      t.string :project_name
      t.integer :numbering_category_id
      t.integer :numbering_kind_id
      t.integer :numbering_partner_id
      t.integer :number
      t.string :document
      t.text :remarks
      t.string :publisher
      t.timestamp :created_on
      t.timestamp :updated_on
    end
  end
end
