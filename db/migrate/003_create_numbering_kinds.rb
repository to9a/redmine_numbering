class CreateNumberingKinds < ActiveRecord::Migration
  def change
    create_table :numbering_kinds do |t|
      t.string :identifier
      t.string :disp_name
    end
  end
end
