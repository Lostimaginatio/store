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

    def how_we_work
      @page = Spree::Page.find_by_slug('/how_we_work_info')
    end

    def pickup
      @page = Spree::Page.find_by_slug('/pickup_info')
    end

    def vacancies
      @page = Spree::Page.find_by_slug('/vacancies_info')
    end

    def brands
      @page = Spree::Page.find_by_slug('/brands_info')
    end

    def catalogs
      @page = Spree::Page.find_by_slug('/catalogs_info')
    end

    def certificates
      @page = Spree::Page.find_by_slug('/certificates_info')
    end

    def price
      @page = Spree::Page.find_by_slug('/price_info')
    end
  end

end
