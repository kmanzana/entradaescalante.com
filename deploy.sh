echo "Running Travis Deployment"
middleman build
middleman s3_sync --environment=$1
