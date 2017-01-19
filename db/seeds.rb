# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

Spree::Page.create! :title => 'Доставка', :body => '<h1>Информация о доставке</h1>', :slug => '/delivery_info'
Spree::Page.create! :title => 'О нас', :body => '<h1>Информация о компании</h1>', :slug => '/about_info'
Spree::Page.create! :title => 'Контакты', :body => '<h1>Информация о контактах</h1>', :slug => '/contacts_info'
Spree::Page.create! :title => 'Главная нижняя часть', :body => '<h1>Текст сверху</h1>', :slug => '/main_bottom_info'
Spree::Page.create! :title => 'Главная верхняя часть', :body => '<h1>Текст снизу</h1>', :slug => '/main_top_info'
