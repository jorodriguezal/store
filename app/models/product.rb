class Product < ApplicationRecord
    has_one_attached :featured_image # This line allows the Product model to have one attached image, which is typically used for a featured image.
    has_rich_text :description # This line adds rich text functionality to the description attribute of the Product model.
    validates :name, presence: true
end
