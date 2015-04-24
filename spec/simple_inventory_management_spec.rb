require 'rails_helper'

describe SimpleInventoryManagement::HasInventoryHandling do

  let(:default_amount) { 1 }
  let(:item) { Item.create }

  before do
    item.amount = default_amount
  end

  context "with 'has_inventory_handling' added to a model" do
    subject { item }

    it { should respond_to(:increase_amount) }
    it { should respond_to(:decrease_amount) }
  end

#  it "adds '.increase' to the model" do
#    expect{item.increase}.to change{item.count}.from(default_amount).to(default_amount + 1)
#  end
#  it "adds '.decrease' to the model" do
#    expect{item.decrease}.to change{item.count}.from(default_amount).to(default_amount - 1)
#  end
end