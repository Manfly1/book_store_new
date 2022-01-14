# frozen_string_literal: true

Rake::Task['assets:precompile'].clear
namespace :assets do
  task 'precompile' do
    puts 'Not pre-compiling assets...'
  end

  task compile_assets: [:set_rails_env] do
    invoke 'deploy:assets:precompile'
    invoke 'deploy:assets:backup_manifest'
  end

  desc 'Cleanup expired assets'
  task cleanup_assets: [:set_rails_env] do
    next unless fetch(:keep_assets)

    on release_roles(fetch(:assets_roles)) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "'assets:clean[#{fetch(:keep_assets)}]'"
        end
      end
    end
  end
end
