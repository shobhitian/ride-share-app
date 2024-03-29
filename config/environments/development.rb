require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false
  #config.hosts << "8196-112-196-113-2.ngrok-free.app"
  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true
  


  #config.action_controller.default_url_options = { host: 'imaginative-concha-5b2766.netlify.app', protocol: 'https' }

  config.action_mailer.default_url_options = { host: 'https://0e25-112-196-113-2.ngrok-free.app' }
  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true
  config.hosts << "0e25-112-196-113-2.ngrok-free.app"
    #config.hosts << ENV['HOSTS']
  #for real time messaging
  config.action_cable.url = 'wss://0e25-112-196-113-2.ngrok-free.app'
  #config.action_cable.url = 'ws://localhost:3000/cable'


  config.action_cable.allowed_request_origins = ['https://0e25-112-196-113-2.ngrok-free.app']


 
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #   :user_name => 'a55699a510d9b8',
  #   :password => '2ae75d4ad68c37',
  #   :address => 'sandbox.smtp.mailtrap.io',
  #   :domain => 'sandbox.smtp.mailtrap.io',
  #   :port => '2525',
  #   :authentication => :cram_md5
  # }

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:              'smtp.gmail.com',
      port:                 587,
      domain:               '8697-112-196-113-2.ngrok-free.app',
      user_name:            'harpreetvallah2@gmail.com',
      password:             'fvjfwycrflgltfgz',
      authentication:       'plain',
      enable_starttls_auto: true,
     }


  config.action_mailer.perform_deliveries = true
  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  config.action_cable.disable_request_forgery_protection = true
  config.action_cable.mount_path = '/cable'

end
