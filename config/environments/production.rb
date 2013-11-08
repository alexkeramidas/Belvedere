BelvedereGit::Application.configure do
    # Settings specified here will take precedence over those in config/application.rb.

    ENV["DATABASE_URL"] = 'postgres://qitjibqjzsedhf:nqKQx7TbBC2uLpAeFnM_u_BuH0@ec2-54-228-235-149.eu-west-1.compute.amazonaws.com:5432/dfpf5kmq39mr72'

    #Correct Paperclip configuration to force Rich Editor to upload to the same path as Paperclip in S3

    config.paperclip_defaults = {
        :storage => :s3,
        :s3_host_name => 's3-eu-west-1.amazonaws.com',
        :url => 'belvedere-assets.s3-website-eu-west-1.amazonaws.com',
        :path => 'app/public/photos/rich_editor/:style/:basename_:token.:extension',
        :s3_credentials => {
            :bucket => ENV['S3_BUCKET_NAME'],
            :access_key_id => ENV['AWSAccessKeyId'],
            :secret_access_key => ENV['AWSSecretKey']
        }
    }

    # config.assets.paths << Rails.root.join('lib', 'assets', 'stylesheets', 'rich')

    # Code is not reloaded between requests.
    config.cache_classes = true

    # Eager load code on boot. This eager loads most of Rails and
    # your application in memory, allowing both thread web servers
    # and those relying on copy on write to perform better.
    # Rake tasks automatically ignore this option for performance.
    config.eager_load = true

    # Full error reports are disabled and caching is turned on.
    config.consider_all_requests_local       = false
    config.action_controller.perform_caching = true

    # Enable Rack::Cache to put a simple HTTP cache in front of your application
    # Add `rack-cache` to your Gemfile before enabling this.
    # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
    # config.action_dispatch.rack_cache = true

    # Disable Rails's static asset server (Apache or nginx will already do this).
    config.serve_static_assets = true

    # Compress JavaScripts and CSS.
    config.assets.js_compressor = :uglifier
    # config.assets.css_compressor = :sass

    # Do not fallback to assets pipeline if a precompiled asset is missed.
    config.assets.compile = false

    # Generate digests for assets URLs.
    config.assets.digest = true

    # Version of your assets, change this if you want to expire all your assets.
    config.assets.version = '1.0'

    # Specifies the header that your server uses for sending files.
    # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
    # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

    # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
    # config.force_ssl = true

    # Set to :debug to see everything in the log.
    config.log_level = :info

    # Prepend all log lines with the following tags.
    # config.log_tags = [ :subdomain, :uuid ]

    # Use a different logger for distributed setups.
    # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

    # Use a different cache store in production.
    # config.cache_store = :mem_cache_store

    # Enable serving of images, stylesheets, and JavaScripts from an asset server.
    # config.action_controller.asset_host = "http://assets.example.com"

    # Precompile additional assets.
    # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
    # config.assets.precompile += %w( search.js )
    config.assets.precompile += %w( *.png *.jpg *.jpeg *.gif )

    # Ignore bad email addresses and do not raise email delivery errors.
    # Set this to true and configure the email server for immediate delivery to raise delivery errors.
    # config.action_mailer.raise_delivery_errors = false

    # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
    # the I18n.default_locale when a translation can not be found).
    config.i18n.fallbacks = true

    # Send deprecation notices to registered listeners.
    config.active_support.deprecation = :notify

    # Disable automatic flushing of the log to improve performance.
    # config.autoflush_log = false

    # Use default logging formatter so that PID and timestamp are not suppressed.
    config.log_formatter = ::Logger::Formatter.new
end
