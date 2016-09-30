require 'dotenv'
require 'slim'

Dotenv.load

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy '/this-page-has-no-template.html', '/template-file.html', locals: {
#  which_fake_page: 'Rendering a fake page with a local variable' }

###
# Helpers
###

configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
end

configure :staging do
  activate :s3_sync do |s3_sync|
    s3_sync.bucket                     = 'staging.entradaescalante.com'
    s3_sync.region                     = 'us-west-2'
    s3_sync.aws_access_key_id          = ENV['AWS_ACCESS_KEY_ID']
    s3_sync.aws_secret_access_key      = ENV['AWS_SECRET_ACCESS_KEY']
    s3_sync.prefix                     = ''
    s3_sync.index_document             = 'index.html'
    s3_sync.error_document             = '404.html'
  end
end

configure :production do
  activate :s3_sync do |s3_sync|
    puts ENV['AWS_ACCESS_KEY_ID']
    puts ENV['AWS_SECRET_ACCESS_KEY']

    s3_sync.bucket                     = 'entradaescalante.com'
    s3_sync.region                     = 'us-east-1'
    s3_sync.aws_access_key_id          = ENV['AWS_ACCESS_KEY_ID']
    s3_sync.aws_secret_access_key      = ENV['AWS_SECRET_ACCESS_KEY']
    s3_sync.prefix                     = ''
    s3_sync.index_document             = 'index.html'
    s3_sync.error_document             = '404.html'
  end
end
