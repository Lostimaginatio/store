module Spree

  class StaticPagesController < Spree::StoreController
    def about
      @page = Spree::Page.find_by_slug('/about_info')
    end

    def delivery
      @page = Spree::Page.find_by_slug('/delivery_info')
    end

    def contacts
      @page = Spree::Page.find_by_slug('/contacts_info')
    end
  end

end
