# The webpack must compile assets before assets:environment task.
# Otherwise Sprockets sees no changes and don't precompile assets.
Rake::Task['assets:precompile']
  .clear_prerequisites
  .enhance(['assets:compile_environment'])

Rake::Task['assets:clobber'].enhance do
  Rake::Task['assets:clobber_webpack'].invoke
end

namespace :assets do
  #In this task, set prerequisites for the assets:precompile task
  task :compile_environment => :webpack do
    Rake::Task['assets:environment'].invoke
  end

  desc 'Compile assets with webpack'
  task :webpack do
    sh "NODE_ENV=#{Rails.env} npm run build"
  end

  desc 'Remove compiled assets by webpack'
  task :clobber_webpack do
    rm_rf "#{Rails.application.config.root}/app/assets/javascripts/application.js"
    rm_rf "#{Rails.application.config.root}/app/assets/stylesheets/application.scss"
  end
end
