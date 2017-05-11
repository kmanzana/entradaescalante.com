require 'dotenv'
require 'slim'

Dotenv.load

set :url_root, 'http://entradaescalante.com'
activate :search_engine_sitemap
activate :dato, live_reload: true

###
# Page options, layouts, aliases and proxies
###

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# KM 4/17/17: due to how middleman 4 collections work (http://bit.ly/2jHZTI9),
# always use `dato` inside a `.tap` method block
dato.tap do |dato|
  dato.rooms.each do |room|
    proxy "/rooms/#{room.slug}.html", '/templates/room', locals: {
      room: room
    }, ignore: true
  end
end

###
# Helpers
###

helpers do
  def markdown(source)
    Tilt[:markdown].new { source }.render(self)
  end

  def parse_and_split(amenities_text, limit: nil)
    unless amenities_text.to_s.empty?
      amenities = YAML.load(amenities_text)
      amenities = amenities.first(limit) if limit
      amenities.each_slice((amenities.size/2.0).ceil).to_a
    end
  end
end

configure :development do
  activate :livereload
  activate :pry
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
