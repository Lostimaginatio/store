module Spree
  class SalesController < Spree::StoreController

    def index
      @sales = Sale.page params[:page]
    end

    def show
      @sale = Sale.find params[:id]
    end
  end
end