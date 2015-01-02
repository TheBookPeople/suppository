# Super Simple Apt Repository
[![Build Status](https://travis-ci.org/TheBookPeople/suppository.svg?branch=develop)](https://travis-ci.org/TheBookPeople/suppository) [![Code Climate](https://codeclimate.com/github/TheBookPeople/suppository/badges/gpa.svg)](https://codeclimate.com/github/TheBookPeople/suppository) [![Test Coverage](https://codeclimate.com/github/TheBookPeople/suppository/badges/coverage.svg)](https://codeclimate.com/github/TheBookPeople/suppository) 

Based on the ideas from Super Simple Apt Repository https://github.com/lukepfarrar/suppository.

A RubyGem that can be used to manage a simple apt repository.

## Installation

    $ gem install suppository

## Build

### Prerequisites

Ruby 2.0.0 (We use RVM to manage the Ruby Version https://rvm.io/ )
Bundler
RubyGems

If you are developing on a Mac the you will need to install dpkg for the tests to pass. The simplest way to install it is with 
Homebrew (see http://brew.sh/ on how to install Homebrew)

    $ brew install dpkg

### Run tests
The default rake task will run code quality checks and all the tests.
 
    $ bundle install
	$ bundle execute rake

If you want to automatically run the tests during development, you can use Guard. Guard will watch for file changes
and run the appropriate tests. See https://github.com/guard/guard for more information on guard

    $bundle exec guard	

### Create Gem

    $bundle exec build	

This will run all the tests and then create a gem file. NOTE: Only files tracked by Git will be included in the gem.
## Usage

    $suppository create REPOSITORY_PATH
    $suppository add REPOSITORY DIST_NAME COMPONENT_NAME DEB_FILE

## Contributing

1. Fork it ( https://github.com/TheBookPeople/suppository/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
