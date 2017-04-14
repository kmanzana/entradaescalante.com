require 'dotenv'
require 'slim'

Dotenv.load

set :url_root, 'http://entradaescalante.com'
activate :search_engine_sitemap

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

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     'Helping'
#   end
# end

activate :dato, live_reload: true

configure :development do
  activate :livereload
end


configure :build do
  activate :asset_hash
  activate :gzip
  # activate :imageoptim # doesn't support MM4 https://github.com/plasticine/middleman-imageoptim/issues/46
  activate :minify_css
  activate :minify_html
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

  caching_policy 'text/html', max_age: 0, must_revalidate: true
  default_caching_policy max_age:(60 * 60 * 24 * 365)
end

configure :production do
  activate :s3_sync do |s3_sync|
    s3_sync.bucket                     = 'entradaescalante.com'
    s3_sync.region                     = 'us-east-1'
    s3_sync.aws_access_key_id          = ENV['AWS_ACCESS_KEY_ID']
    s3_sync.aws_secret_access_key      = ENV['AWS_SECRET_ACCESS_KEY']
    s3_sync.prefix                     = ''
    s3_sync.index_document             = 'index.html'
    s3_sync.error_document             = '404.html'
  end

  caching_policy 'text/html', max_age: 0, must_revalidate: true
  default_caching_policy max_age:(60 * 60 * 24 * 365)
end
