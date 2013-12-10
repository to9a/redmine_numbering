class CreateNumberingPrefixes < ActiveRecord::Migration
  def change
    create_table :numbering_prefixes do |t|
      t.integer :project_id
      t.string :fixed
      t.integer :assigned
      t.string :subject
    end
  end
end
