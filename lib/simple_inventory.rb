module SimpleInventory
  class << self
    attr_accessor :configuration
  end

  def self.setup
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  module HasSimpleInventory
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def has_simple_inventory
        include SimpleInventory::HasSimpleInventory::LocalInstanceMethods

        self.send(:private, :find_asset)
        self.send(:private, :update_amount)
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
        new_amount = yield find_asset['amount']
        sql = "UPDATE inventory_management SET amount=#{new_amount} WHERE model='#{model_name}' AND instance_id=#{instance_id}"
        ActiveRecord::Base.connection.insert(sql)

        new_amount
      end

      def amount=(amount)
        update_amount { amount }
      end

      def amount
        find_asset['amount']
      end

      def model_name
        self.class.model_name
      end

      def instance_id
        self.id
      end
    end
  end

end

ActiveRecord::Base.send :include, SimpleInventory::HasSimpleInventory
