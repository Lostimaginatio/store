class ProductGrid

  include Datagrid

  scope do
    Spree::Product
  end

  filter(:name, :string, header: 'Наименование') do |value, scope|
    scope.where("spree_products.name like '%#{value}%'")
  end
  filter(:sku, :string, header: 'Код товара') do |value, scope|
    scope.where("spree_variants.sku like '%#{value}%'")
  end
  filter(:price, :integer, range: true, header: 'Ценовой диапозон') do |value, scope|
    scope.where("spree_prices.amount >= #{value[0]}") if value[0]
    scope.where("spree_prices.amount <= #{value[1]}") if value[1]
  end

  column(:name, header: 'Наименование товара', :html => true) do |product|
    link_to product.name, spree.product_url(product.id, @taxon.try(:id)), class: 'product-name-link'
  end
  column(:sku, header: 'Код товара')
  column(:price, :order => "spree_prices.amount", header: 'Цена, руб.', :html => true) do |product|
    display_price(product)
  end

  column(:count, header: 'Количество в корзине', :html => true) do |count|
    render :partial => "grid/count_form", :object => count
  end
end