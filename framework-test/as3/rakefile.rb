require 'sprout'
sprout 'as3'

##########################################
# Compile the Test Harness

mxmlc 'bin/AsUnit3Runner.swf' do |t|
  t.default_size = '1000 600'
  t.input = 'AsUnitTestRunner.as'
  t.source_path << '../../framework/as3'
end

##########################################
# Launch the Test Harness

desc "Compile and run the test harness"
flashplayer :run => 'bin/AsUnit3Runner.swf'

task :default => :run

