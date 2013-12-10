class CreateNumberingPartners < ActiveRecord::Migration
  def change
    create_table :numbering_partners do |t|
      t.string :identifier
      t.string :disp_name
    end
  end
end
