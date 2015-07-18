namespace :generate do
  desc 'Create a new migration'
  task :migration, [:name] => :environment do |_, args|
    if args[:name].nil?
      puts 'You must specify a name for your migration!'
      exit 1
    end

    content = <<-EOF.gsub(/^ {6}/, '')
      Sequel.migration do
        change do\n
        end
      end
    EOF

    timestamp = Time.now.to_i
    filename = File.join '.', 'db', "#{timestamp}_#{args[:name]}.rb"

    File.open filename, 'w' do |file|
      file.write content
    end
  end
end
