require 'fileutils'

namespace :userdata do
  desc "Clears the userdata directory"
  task :clear do
    FileUtils.rm Dir.glob('./userdata/**/*')
  end
end