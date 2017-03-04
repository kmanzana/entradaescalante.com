### Project setup
##### Getting the project
`cd` to projects folder then to get the project on your machine run
``` bash
git clone https://github.com/kmanzana/entradaescalante.com.git
cd entradaescalante.com
```

##### Installing
Install RVM with cygwin on windows using [this tutorial](http://blog.developwithpassion.com/2012/03/30/installing-rvm-with-cygwin-on-windows/)
Make sure you are using the correct version of Ruby (see `Gemfile:3`)
``` bash
rvm install ruby-2.4.0 # for Ruby version 2.4.0
rvm --default use 2.4.0 # set this version as default and use it currently
```

Install `bundler`
```bash
gem install bundler
```

Install project gems
```
bundle install
```

### Local development
##### Running the server
``` bash
middleman serve
```

### Deployment
##### To build the site prior to deploy
``` bash
middleman build
```

##### To check out and verify the build
``` bash
cd build
python -m SimpleHTTPServer
```
then open the server at [localhost:8000](http://localhost:8000)

##### To deploy to S3
``` bash
middleman s3_sync --environment=staging # use production for env to deploy to live site
```

once you're done it's best to delete the `build` directory
``` bash
rm -rf build
```
