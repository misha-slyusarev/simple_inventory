namespace :simple_inventory_management do

  desc 'Making required schema changes'
  task :install do
    system 'rails g simple_inventory_management'
  end
end
