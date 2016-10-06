Spree::HomeController.class_eval do
  def index
    @searcher = build_searcher(params.merge(include_images: true))
    products = @searcher.retrieve_products.includes(:possible_promotions)

    @products = ProductGrid.new params[:product_grid]
    @products.scope { products }

    @taxonomies = Spree::Taxonomy.includes(root: :children)
  end
end