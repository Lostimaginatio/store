Spree::TaxonsController.class_eval do

  def show
    @taxon = Spree::Taxon.friendly.find(params[:id])
    return unless @taxon

    @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
    products = @searcher.retrieve_products.includes(:possible_promotions)
    @products = ProductGrid.new params[:product_grid]
    @products.scope { products }

    @taxonomies = Spree::Taxonomy.includes(root: :children)
  end

end