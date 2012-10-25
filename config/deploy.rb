require 'rvm/capistrano' # Для работы rvm
require 'bundler/capistrano'

set :application, "admintools"
set :domain, "192.168.137.34"
set :repository, "git@github.com:is-valid/admintools.git"
set :rails_env, "production"
set :branch, "teamleader"
#set :deploy_via, :remote_cache # Указание на то, что стоит хранить кеш репозитария локально и с каждым деплоем лишь подтягивать произведенные изменения. Очень актуально для больших и тяжелых репозитариев.
set :user, "dimon"
set :use_sudo, false
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

set :rvm_ruby_string, 'ruby-1.9.3-p194' # Это указание на то, какой Ruby интерпретатор мы будем использовать.

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :deploy_to, "/home/dimon/web/apps/admintools"

before 'deploy:setup', 'rvm:install_rvm', 'rvm:install_ruby' # интеграция rvm с capistrano настолько хороша, что при выполнении cap deploy:setup установит себя и указанный в rvm_ruby_string руби.


namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
    run "bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end

after 'deploy:update_code', :roles => :app do
  # Здесь для примера вставлен только один конфиг с приватными данными - database.yml. Обычно для таких вещей создают папку /srv/myapp/shared/config и кладут файлы туда. При каждом деплое создаются ссылки на них в нужные места приложения.
  run "rm -f #{current_release}/config/database.yml"
  run "ln -s #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
end

#ssh_options[:port] = 7822
#set :repository, "svn+ssh://root@localhost/var/www/test.com"

#server "test.com", :app, :web, :db, :primary => true


#role :web, "admintools.com"                          # Your HTTP server, Apache/etc
#role :app, "admintools.com"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"




# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     #run touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end