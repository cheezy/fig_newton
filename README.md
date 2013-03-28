# FigNewton

[![Build Status](http://travis-ci.org/cheezy/fig_newton.png)](http://travis-ci.org/cheezy/fig_newton)

Manages configuration for test suites.  It is common to need different configuration information for different test environments.  For example, the base_url or database login information might change when you move from development to a test environment.  FigNewton makes it simple to create and use this information.

## Usage

Using FigNewton is as simple as specifying the directory to use, loading a file from that directory, and then calling methods on the module that match the keys in the file.  Let's look at an example.

By default the FigNewton gem will look for files in the 'config/environments' directory.  If you wish to use a different directory you simply set the correct directory like this - `FigNewton.yml_directory = 'other_directory'`.  

By default, FigNewton will read a file named `default.yml` but you can name your _yml_ files anything you want.  Let's assume that we have files named ci.yml, test.yml, and system_test.yml in that directory.  All we need to do is call the `load` method in order to begin using a file:

````ruby
FigNewton.load('system_test.yml')
````

Next we simply begin calling methods on the FigNewton module that match our keys.  Let's assume the system_test.yml file contains the following entries:

    base_url:  http://system_test.mycompany.com
    database_user: cheezy
    database_password: secret

In our code we can call methods that match the keys.  Here is an example PageObject where we are using the `base_url` entry:

````ruby
class MyPage
  include PageObject
  
  page_url "#{FigNewton.base_url}/my_page.html"
end
````

We can also supply default values which will be returned if the property does not exist:
````ruby
class MyPage
  include PageObject
  
  page_url "#{FigNewton.base_url("http://cheezyworld.com")}/my_page.html"
end
````

If you have an environment variable `FIG_NEWTON_FILE` set then it will read that file by default.  This makes it easy to set the environment via your `cucumber.yml` file like this:

````
default:  FIG_NEWTON_FILE=local.yml --color --format pretty
ci:       FIG_NEWTON_FILE=ci.yml --color --format pretty
test:     FIG_NEWTON_FILE=test.yml --color --format pretty
staging:  FIG_NEWTON_FILE=staging.yml --color --format pretty
````

When you run the cucumber command you can easily select the correct profile which in turn will select the correct configuration file for your environment.

Another way to set the file to use is to create a file based on the hostname of the computers on which it will run.  For example, if we have an environment named _development.mydomain.com_ and another environment named _test.mydomain.com_ and yet another named _systemtest.mydomain.com_ we can create files named the same as the domain with the yml extension.


## Installation

Add this line to your application's Gemfile:

    gem 'fig_newton'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fig_newton

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
