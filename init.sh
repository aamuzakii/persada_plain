rails new persada_mart --skip-active-record
ls
cd persada_mart
ls
code .


ADD GEM
gem 'mongoid'
gem 'pry', '~> 0.13.1'
gem 'rack-cors'
gem 'money'


rails g mongoid:config  
rails g scaffold product name:string image_url:string description:text category:string price:integer stock_type:string
rails g scaffold customer name:string phone:string
rails g scaffold order additional_info:string order_note:string delivery_note:string delivery_date:date order_number:string delivery_cost:integer subtotal:integer total:integer
rails g scaffold products_ordered qty_ordered:integer
code .
rails s
code .
bundle
git init