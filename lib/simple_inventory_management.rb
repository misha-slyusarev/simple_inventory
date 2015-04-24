module SimpleInventoryManagement

  module HasInventoryHandling
    extend ActiveSupport::Concern

    included do
      #self.send(:private, :find_record)
      #self.send(:private, :change_inventory)
    end

    module ClassMethods
      def has_inventory_handling
        include SimpleInventoryManagement::HasInventoryHandling::LocalInstanceMethods
      end

      def set_default_amount(amount: 0)
      end
    end

    module LocalInstanceMethods

      def decrease_amount(value: 1)
        update_amount { |amount| amount - value }
      end

      def increase_amount(value: 1)
        update_amount { |amount| amount + value }
      end

      def find_asset
        sql = "SELECT amount FROM inventory_management WHERE model='#{model_name}' AND instance_id=#{instance_id}"
        asset = ActiveRecord::Base.connection.execute(sql).first
        asset.blank? ? initialize_asset : asset
      end

      def initialize_asset(amount: 0)
        sql = "INSERT INTO inventory_management (model,instance_id,amount) VALUES('#{model_name}',#{instance_id},#{amount})"
        ActiveRecord::Base.connection.insert(sql)
        find_asset
      end

      def update_amount
        new_amount = yield find_asset[:amount]
        sql = "UPDATE inventory_management SET amount=#{new_amount} WHERE model='#{model_name}' AND instance_id=#{instance_id}"
        ActiveRecord::Base.connection.insert(sql)
      end

    end
  end

  def model_name
    self.class.model_name
  end

  def instance_id
    self.id
  end
end

ActiveRecord::Base.send :include, SimpleInventoryManagement::HasInventoryHandling
