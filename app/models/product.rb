class Product < ApplicationRecord
    has_many :subscribers, dependent: :destroy # This line establishes a one-to-many relationship between the Product and Subscriber models, meaning that each product can have many subscribers.
    has_one_attached :featured_image # This line allows the Product model to have one attached image, which is typically used for a featured image.
    has_rich_text :description # This line adds rich text functionality to the description attribute of the Product model.
    validates :name, presence: true
    validates :inventory_count, numericality: { greater_than_or_equal_to: 0 } # This line validates that the inventory_count attribute is a number and is greater than or equal to 0.
end