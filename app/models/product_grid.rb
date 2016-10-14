class ProductGrid

  include Datagrid

  scope do
    Spree::Product
  end

  filter(:id, :integer)
  filter(:created_at, :date, :range => true)

  column(:id)
  column(:name)

  column(:count, header: 'Количество в корзине', :html => true) do |count|
    render :partial => "grid/count_form", :object => count
  end
end