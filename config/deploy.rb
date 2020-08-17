# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :deploy_user, ENV.fetch("DEPLOY_USER", "duy_nguyen")
server "54.255.211.110", user: fetch(:deploy_user), roles: %w(app db web)
set :ssh_options, { forward_agent: false, auth_methods: %w(publickey) }

set :repo_url, "git@github.com:DuyNguyen05/vaccination_center_management.git"
set :application, "vaccine-center-management"
set :branch, :deploy
set :deploy_to, "/home/#{fetch(:deploy_user)}/cap/vaccine-center-management"

append :linked_files, ".env", "config/database.yml", "config/credentials.yml.enc", "config/master.key"

append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads", "vendor/bundle"

set :rbenv_type, :user
set :rbenv_ruby, File.read(".ruby-version").strip

set :bundle_path, -> { shared_path.join("vendor", "bundle") }

after "deploy:publishing", "deploy:restart"

namespace :deploy do
  task :restart do
    on roles(:app) do
      execute "sudo service puma restart"
    end
  end
end
