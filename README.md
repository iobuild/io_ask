io_ask is an engine for Rails that aims to be the best little ask system ever.
The end goal is to have an engine that can be dropped into an application that
provides the basic functionality of ask/answer, topics and comments.



# Installation

Installing io_ask is easy.

## Specify Gem dependencies

# Installation

Using Rails 4

```ruby
gem 'io_ask', :github => "git@github.com:iobuild/io_ask.git"
```

And then one of `kaminari` or `will_paginate`
```ruby
gem 'kaminari', '0.15.1'
# OR
gem 'will_paginate', '3.0.5'
```
And then need awesome_nested_set to create Category model
```ruby
gem 'awesome_nested_set'
```

## Run the installer

**Ensure that you first of all have a `User` model and some sort of authentication system set up**. We would recommend going with [Devise](http://github.com/plataformatec/devise), but it's up to
you. All io_ask needs is a model to link topics and posts to.

Run the installer and answer any questions that pop up. There's sensible defaults there if you don't want to answer them.

```shell
rails g io_ask:install
```

## Set up helper methods in your user model

io_ask uses a `ioask_name` and `ioask_avatar` (which defaults as `to_s`) method being available on your `User` model so that it can display the user's name in posts. Define it in your model like this:

```ruby
def ioask_name
  name
end

def ioask_avatar
  avatar_url
end
```

Please note that if you are using Devise, User model does not have `name` column by default,
so you either should use custom migration to add it or use another column (`email` for example).

It also uses an optional `ioask_email` method

```ruby
def ioask_email
  email_address
end
```

## Require basic io_ask assets

Add this line to your `application.js` file to load required JavaScript files:

```js
//= require io_ask
```

Add this line to your `application.css` to apply required styling:

```css
*= require 'io_ask/application'
```


And you're done! Yaaay!


## Features

Here's a comprehensive list of the features currently in io_ask:

* Topics
  * Viewing all topics for a io_ask
  * Creating of new topics
  * Editing topics
* Comments
  * Replying to topics
  * Deleting own topics
  * Editing comments


If there's a feature you think would be great to add to io_ask, let us know on [the Issues
page](https://github.com/iobuild/io_ask/issues)



io_ask's default layout includes this tag.

## View Customisation

If you want to customise io_ask, you can copy over the views using the (Devise-inspired) `io_ask:views` generator:

    rails g io_ask:views

You will then be able to edit the io_ask views inside the `app/views/io_ask` of your application. These views will take precedence over those in the engine.

## Extending Classes

All of io_ask business logic (models, controllers, helpers, etc) can easily be extended / overridden to meet your exact requirements using standard Ruby idioms.

Standard practice for including such changes in your application or extension is to create a directory app/decorators. place file within the relevant app/decorators/models or app/decorators/controllers directory with the original class name with _decorator appended.

### Adding a custom method to the Post model:

```ruby
# app/decorators/models/io_ask/topic_decorator.rb

IoAsk::Topic.class_eval do
  def some_method
    ...
  end
end
```

### Adding a custom method to the TopicsController:

```ruby
# app/decorators/controllers/io_ask/posts_controller_decorator.rb

IoAsk::TopicsController.class_eval do
  def some_action
    ...
  end
end
```

The exact same format can be used to redefine an existing method.

## We currently have support for the following languages:

* Chinese (Simplified, zh-CN)

Patches for new translations are very much welcome!


## OMG BUG! / OMG FEATURE REQUEST!

File an issue and we'll get around to it when we can.

## Developing on io_ask

io_ask is implemented as a Rails engine and its specs are run in the context of a dummy Rails app. The process for getting the specs to run is similar to setting up a regular rails app:

    bundle exec rake io_ask:dummy_app

Once this setup has been done, io_ask's specs can be run by executing this command:

    bundle exec rspec spec

If all the tests are passing (they usually are), then you're good to go! Develop a new feature for io_ask and be lavished with praise!

## Contributors

* Arly Xiao
* [And more](https://github.com/iobuild/io_ask/contributors)

## Places using io_ask

* [Example Name](http://example.com)

If you want yours added here, just ask!
