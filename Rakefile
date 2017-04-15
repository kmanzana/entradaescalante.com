task default: %w[test]

task :test do
  puts "\nBuilding project"
  try 'middleman build'
end

task :deploy do
  puts "\nDeploying to S3"
  try 'middleman deploy'
end

namespace :travis do
  task :script do
    Rake::Task["test"].invoke
  end
end

# Helper so we fail as soon as a command fails.
def try(command)
  system command
  if $? != 0 then
    raise "Command: `#{command}` exited with code #{$?.exitstatus}"
  end
end
