# Super Simple Apt Repository
[![Build Status](https://travis-ci.org/TheBookPeople/suppository.svg?branch=develop)](https://travis-ci.org/TheBookPeople/suppository) [![Code Climate](https://codeclimate.com/github/TheBookPeople/suppository/badges/gpa.svg)](https://codeclimate.com/github/TheBookPeople/suppository) [![Test Coverage](https://codeclimate.com/github/TheBookPeople/suppository/badges/coverage.svg)](https://codeclimate.com/github/TheBookPeople/suppository) [![Gem Version](https://badge.fury.io/rb/suppository.svg)](http://badge.fury.io/rb/suppository)

Based on the ideas from Super Simple Apt Repository https://github.com/lukepfarrar/suppository.

A RubyGem that can be used to manage a simple apt repository.

## Installation

    $ gem install suppository
	
## Usage

### Help

    $ suppository help

### Version

    $ suppository version

### Create new repository

    $ suppository create REPOSITORY_PATH

### Add Deb to existing repository

    $ suppository add REPOSITORY_PATH DIST_NAME COMPONENT_NAME DEB_FILE

## Build

### Prerequisites

Tested on Ruby 1.9.3, 2.0.0, 2.1.5 and 2.2.0

Bundler

RubyGems

#### OSX

If you are developing on a Mac the you will need to install dpkg and gpg for the tests to pass. The simplest way to install it is with 
Homebrew (see http://brew.sh/ on how to install Homebrew)

    $ brew install dpkg
	$ brew install gpg

#### Ubuntu / Debian 

dpkg will already be installed but you might need to install gpg.
 

### Run tests
The default rake task will run code quality checks and all the tests.
 
    $ bundle install
    $ bundle exec rake

If you want to automatically run the tests during development, you can use Guard. Guard will watch for file changes
and run the appropriate tests. See https://github.com/guard/guard for more information on guard

    $ bundle exec guard	

### Create Gem

    $ bundle exec rake build	

This will run all the tests and then create a gem file. NOTE: Only files tracked by Git will be included in the gem.

### Release

Check everything build and the tests pass

    $ bundle exec build

Create release using GitFlow (http://danielkummer.github.io/git-flow-cheatsheet/)

    $ git flow release start [version]

Update the version number and commit changes

    $ vi lib/suppository/version.rb

Finish release

    $ git flow release finish [version]

Push changes

    $ git push
    $ git checkout develop
	$ git push
    $ git push --tags

Travis will now build and deploy to RubyGems.org

## Contributing

1. Fork it ( https://github.com/TheBookPeople/suppository/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
