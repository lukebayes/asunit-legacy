require 'fileutils'

desc "get rid of previously built files"
task :clean do
end

desc "full project build"
task :complete => [:clean, :default] do
end

desc "incremental project build"
task :default do
end

task :move do

end

desc "publish build to the web"
task :publish => :complete do
end
