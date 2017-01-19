# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

Spree::Page.create! :title => 'Главная верхняя часть', :body => '<h1>Текст снизу</h1>', :slug => '/main_top_info'
Spree::Page.create! :title => 'Главная нижняя часть', :body => '<h1>Текст сверху</h1>', :slug => '/main_bottom_info'
Spree::Page.create! :title => 'Доставка', :body => '<h1>Информация о доставке товаров</h1>', :slug => '/delivery_info'
Spree::Page.create! :title => 'Контакты', :body => '<h1>Информация о контактах</h1>', :slug => '/contacts_info'
Spree::Page.create! :title => 'О нас', :body => '<h1>Информация о компании</h1>', :slug => '/about_info'
Spree::Page.create! :title => 'Как мы работаем', :body => '<h1>Информация о том, как мы работаем</h1>', :slug => '/how_we_work_info'
Spree::Page.create! :title => 'Самовывоз', :body => '<h1>Информация о самовывозе товаров</h1>', :slug => '/pickup_info'
Spree::Page.create! :title => 'Вакансии', :body => '<h1>Информация о вакансиях</h1>', :slug => '/vacancies_info'
Spree::Page.create! :title => 'Бренды', :body => '<h1>Информация о брендах</h1>', :slug => '/brands_info'
Spree::Page.create! :title => 'Каталоги', :body => '<h1>Информация о каталогах</h1>', :slug => '/catalogs_info'
Spree::Page.create! :title => 'Сертификаты', :body => '<h1>Информация о сертификатах</h1>', :slug => '/certificates_info'

# Spree::Role.create! :name => 'Новый покупатель'
# Spree::Role.create! :name => 'Проверенный покупатель'