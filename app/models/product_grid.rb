class ProductGrid

  include Datagrid

  scope do
    Spree::Product
  end

  filter(:name, :string, header: 'Наименование') do |value, scope|
    scope.where("name like '%#{value}%'")
  end
  filter(:sku, :string, header: 'Код товара') do |value, scope|
    scope.where("sku like '%#{value}%'")
  end
  filter(:price, :integer, range: true, header: 'Ценовой диапозон')

  column(:name, header: 'Наименование товара', :html => true) do |product|
    link_to product.name, spree.product_url(product.id, @taxon.try(:id)), class: 'product-name-link'
  end
  column(:sku, header: 'Код товара')
  column(:price, :order => "price", header: 'Цена, руб.')

  column(:count, header: 'Количество в корзине', :html => true) do |count|
    render :partial => "grid/count_form", :object => count
  end
end