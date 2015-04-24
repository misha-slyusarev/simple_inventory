namespace :simple_inventory do

  desc 'Making required schema changes'
  task :install do
    system 'rails g simple_inventory'
  end
end
