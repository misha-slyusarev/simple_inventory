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

    module ClassMethods
      def has_simple_inventory
        include SimpleInventory::HasSimpleInventory::LocalInstanceMethods

        self.send(:private, :update_amount)
      end
    end

    module LocalInstanceMethods

      def decrease_amount(value: 1)
        update_amount { |amount| amount - value }
      end

      def increase_amount(value: 1)
        update_amount { |amount| amount + value }
      end

      def update_amount
        new_amount = 0

        self.class.transaction do
          new_amount = yield(amount || new_amount)

          errors = update_attributes(amount: new_amount)
          raise ActiveRecord::Rollback if errors
        end

        new_amount
      end

    end
  end

end

ActiveRecord::Base.send :include, SimpleInventory::HasSimpleInventory
