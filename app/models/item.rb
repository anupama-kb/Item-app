class Item < ApplicationRecord
  belongs_to :item_category
  has_one :item_tax
end
