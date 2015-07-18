namespace :db do
  desc 'Run database migrations'
  task :migrate, [:version] => :environment do |_, args|
    Sequel.extension :migration

    if args[:version]
      puts "Migrating to version #{args[:version]}..."
      Sequel::Migrator.run CentCom::DB, 'db', target: args[:version].to_i
    else
      puts 'Migrating to latest version...'
      Sequel::Migrator.run CentCom::DB, 'db'
    end
  end
end
