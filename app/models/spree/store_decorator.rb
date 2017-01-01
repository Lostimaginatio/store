Spree::Store.class_eval do
  validates :phone_number, presence: true
end