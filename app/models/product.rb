class Product < ApplicationRecord
    has_rich_text :description # This line adds rich text functionality to the description attribute of the Product model.
    validates :name, presence: true
end
