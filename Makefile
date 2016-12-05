.PHONY: run setup test

setup:
	@gem install bundle
	@bundle install
	@bundle exec 'rake db:create db:migrate db:seed'

run:
	@bundle exec rackup -p 3000

run-procfile:
	foreman start

testall: test style

test:
	bundle exec rake db:test:prepare
	bundle exec rspec

style:
	bundle exec rubocop --force-exclusion
