SimpleInventory
---------------
Allows to add a simple inventory management to your Rails model. Install it to your Gemfile:

    gem 'simple_inventory', github: 'misha-slyusarev/simple_inventory'

Simply add *has_simple_inventory* to your ActiveRecord model:

    class Item < ActiveRecord::Base
      has_simple_inventory
    end

Generate and run migration to add a column that will keep inventory in your model:

    rails generate simple_inventory:add_column item
    rake db:migrate

And try it out:

    item = Item.create
    item.amount          # => 0
    item.amount = 1      # => 1
    item.increase_amount # => 2
    item.decrease_amount # => 1
