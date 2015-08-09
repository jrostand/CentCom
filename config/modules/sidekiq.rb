schedule_file = File.join 'config', 'schedule.yml'

if File.exists? schedule_file
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
