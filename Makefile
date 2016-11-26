.PHONY: run setup

setup:
	@gem install bundle
	@bundle install
	@bundle exec 'rake db:create db:migrate db:seed'

run:
	@bundle exec rackup -p 3000
