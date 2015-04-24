module SimpleInventory
  class InstallGenerator < Rails::Generators::Base
    def install
      generate 'migration', 'CreateSimpleInventory model:string instance_id:integer amount:integer'
      rake 'db:migrate'
    end
  end
end
