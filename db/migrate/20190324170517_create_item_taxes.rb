class CreateItemTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :item_taxes do |t|
      t.float :tax
      t.string :tax_type
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
