require 'net/ssh'
require 'net/scp'

Settings = {
  :user => 'admin',
  :ip   => '97.107.138.149',
  :name => 'movie-alert'
}

def remote_path 
  "/var/sinatra/#{Config[:name]}"
end

def ssh(&block)
  Net::SSH.start Settings[:ip], Settings[:user], &block
end

class Net::SSH::Connection::Session
  alias :original_exec! :exec!
  def exec!(command)
    original_exec! "cd #{remote_path}; #{command}"
  end
end

desc 'Restart server'
task :restart do
  ssh.exec! 'sudo apache2ctl graceful'
end

desc 'Deploy application to server'
task :deploy do
  puts `git push`
  ssh do |ssh|
    puts ssh.exec! 'git pull'
    ssh.exec! 'compass -c compass.rb'
  end
  Rake::Task[:restart].invoke
end