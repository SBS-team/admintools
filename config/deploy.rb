require 'rvm/capistrano' # Для работы rvm
require 'bundler/capistrano'

set :application, "admintools"
set :domain, "192.168.137.1"
set :repository, "git@github.com:is-valid/admintools.git"
set :rails_env, "production"
#set :branch, "teamleader"
#set :branch, "update_and_fix_bootstrap"
set :branch, "master"
#set :deploy_via, :remote_cache # Указание на то, что стоит хранить кеш репозитария локально и с каждым деплоем лишь подтягивать произведенные изменения. Очень актуально для больших и тяжелых репозитариев.
set :user, "admintools"
set :use_sudo, false
set :deploy_to, "/var/www/admintools.loc/server"
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

set :rvm_ruby_string, 'ruby-1.9.3-p194' # Это указание на то, какой Ruby интерпретатор мы будем использовать.

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`


role :web, domain
role :app, domain
role :db,  domain, :primary => true
role :resque_worker, domain
role :resque_scheduler, domain

set :workers, { :shedule_event => 1, :local_ping => 1, :domain_jobs_ping => 1, :clear_log => 1}

before 'deploy:setup', 'rvm:install_rvm', 'rvm:install_ruby' # интеграция rvm с capistrano настолько хороша, что при выполнении cap deploy:setup установит себя и указанный в rvm_ruby_string руби.


namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{release_path} && bundle exec unicorn -E #{rails_env} -D; fi"
  end
  task :start do
    #run "cd #{release_path}; bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
    #run "cd #{release_path}; bundle exec unicorn -p 80 -E production"
    run "cd #{release_path}; bundle exec unicorn -E production"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end

after "deploy:update_code",
      "deploy:config_symlink",
      "deploy:config_sarg",
      "deploy:rewrite_production_rb",
      "deploy:db_create",
      "deploy:db_migrate",
      "deploy:db_seed",
      "deploy:bundle_install_no_dev",
      "deploy:start_workers",
      "deploy:start_scheduler"
      #"deploy:start"


namespace :deploy do
  task :config_symlink do
    run "cp #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
  task :config_sarg do
    run "cp -d #{shared_path}/sarg_dir #{release_path}/public/sarg_dir"
  end
  task :rewrite_production_rb do
    run "cp -f #{shared_path}/production.rb #{release_path}/config/environments/production.rb"
  end
  task :db_create, :roles => :app do
    run "cd #{release_path}; RAILS_ENV=production rake db:create"
  end
  task :db_migrate, :roles => :app do
    run "cd #{release_path}; RAILS_ENV=production rake db:migrate"
  end
  task :db_seed, :roles => :app do
    run "cd #{release_path}; RAILS_ENV=production rake db:seed"
  end
  task :bundle_install_no_dev, :roles => :app do
    run "cd #{release_path}; bundle install --no-deployment"
  end
  task :start_workers, :roles => :app do
    run "cd #{release_path}; bundle exec rake resque:work QUEUE=* RAILS_ENV=production -D"
  end
  task :start_scheduler, :roles => :app do
    run "cd #{release_path}; bundle exec rake resque:scheduler RAILS_ENV=production -D"
  end
end

#after 'deploy:update_code', :roles => :app do
  # Здесь для примера вставлен только один конфиг с приватными данными - database.yml. Обычно для таких вещей создают папку /srv/myapp/shared/config и кладут файлы туда. При каждом деплое создаются ссылки на них в нужные места приложения.
  #run "rm -f #{current_release}/config/database.yml"
  #run "ln -s #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
  #run "cd #{release_path}; rake assets:precompile RAILS_ENV=production "
#end

#ssh_options[:port] = 7822
#set :repository, "svn+ssh://root@localhost/var/www/test.com"

#server "test.com", :app, :web, :db, :primary => true


#role :web, "admintools.com"                          # Your HTTP server, Apache/etc
#role :app, "admintools.com"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"




# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
#namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     #run touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
#end