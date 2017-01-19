class Article < Spree::Base
  validates_presence_of :name, :content
end
