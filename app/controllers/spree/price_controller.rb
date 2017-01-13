module Spree
  class PriceController < Spree::StoreController
    respond_to :xls
    def index
      request.format = 'xls'
      # @products = Spree::Product.all
      @taxons = Spree::Taxon.all
      respond_to do |format|
        format.xls
      end
    end
  end
end