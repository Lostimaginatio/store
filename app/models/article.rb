class Article < Spree::Base
  validates_presence_of :name, :content
  paginates_per 10
  max_paginates_per 20
end
