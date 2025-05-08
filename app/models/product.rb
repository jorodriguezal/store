class Product < ApplicationRecord
    has_many :subscribers, dependent: :destroy # This line establishes a one-to-many relationship between the Product and Subscriber models, meaning that each product can have many subscribers.
    has_one_attached :featured_image # This line allows the Product model to have one attached image, which is typically used for a featured image.
    has_rich_text :description # This line adds rich text functionality to the description attribute of the Product model.
    validates :name, presence: true
    validates :inventory_count, numericality: { greater_than_or_equal_to: 0 } # This line validates that the inventory_count attribute is a number and is greater than or equal to 0.

    after_update_commit :notify_subscribers, if: :back_in_stock? # This line sets up a callback that triggers after the product is updated. If the product is back in stock, it will notify subscribers.

    def back_in_stock?
        inventory_count_previously_was.zero? && inventory_count > 0 # This line checks if the inventory count was previously zero and is now greater than zero, indicating that the product is back in stock.
    end

    def notify_subscribers
        subscribers.each do |subscriber|
            ProductMailer.with(product: self, subscriber: subscriber).in_stock.deliver_later # This line iterates over each subscriber and sends them an email notification using the ProductMailer. The deliver_later method queues the email to be sent asynchronously, which is useful for improving performance and user experience.
        end
    end
end