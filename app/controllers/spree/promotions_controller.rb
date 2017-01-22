module Spree
  class PromotionsController < Spree::StoreController

    def index
      @promotions = Spree::Promotion.page params[:page]
    end

    def show
      @promotion = Spree::Promotion.find params[:id]
    end
  end
end