**NOTICE: The project is under development!**

SimpleInventory
---------------
Allows to add a simple inventory management to your Rails model. Simply add *has_simple_inventory* to your ActiveRecord model

    class Item < ActiveRecord::Base
      has_simple_inventory
    end

And check it out

    item = Item.create
    item.amount          # => 0
    item.amount = 1      # => 1
    item.increase_amount # => 2
    item.decrease_amount # => 1
