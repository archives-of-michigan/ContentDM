namespace :gem do
  task :build do
    puts `gem build contentdm.gemspec`
  end
  
  task :reset => 'gem:build' do
    puts `gem uninstall -a contentdm`
    puts `gem install contentdm`
  end
end