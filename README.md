# Molecular

`Molecular` abstracts long atomic CSS strings into reusable, tweakable Ruby
objects. You get all the benefits of working with atomic CSS, without the ugly
markup and verbose API.

Transform your app's views from this...

```html
<a class="f6 link dim ph3 pv2 mb2 dib white bg-black" href="#0">
  A black button
</a>

<a class="f6 link dim ph3 pv2 mb2 dib red bg-black" href="#0">
  A red button
</a>
```

...into this:

```erb
<a class="<%= ui_button %>">A black button</a>

<a class="<%= ui_button.(color: 'red') %>">A red button</a>
```

---

* [Installation](#installation)
* [Usage (Generic)](#usage-generic)
  * [Step 1: Create a Compound](#step-1-create-a-compound)
  * [Step 2: Use your Compound in a view](#step-2-use-your-compound-in-a-view)
  * [Step 3 (optional): Tweak your style keys](#step-3-optional-tweak-your-style-keys)
* [Usage (framework-specific)](#usage-framework-specific)
  * [Rails](#rails)
  * [Sinatra](#sinatra)
  * [Roda](#roda)
* [Development](#development)
* [Contributing](#contributing)
* [Related Projects](#related-projects)

---

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'molecular'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install molecular

## Usage (Generic)

You can use Molecular with any CSS framework, in any Ruby app. In broad strokes,
here's how to style a button with Molecular, using example CSS classes from
[tachyons.css][button].

### Step 1: Create a Molecular::Compound

Somewhere in your app:

```ruby
Button = Molecular.compound(
  color: 'white',
  bg: 'bg-black',
  base: 'f6 link dim ph3 pv2 mb2 dib',
)
```

### Step 2: Use your Compound in a view

Somewhere in an `erb` template:

```erb
<a class="<%= Button %>" href="#">
  A styled button
</a>
<a class="<%= Button.(color: 'yellow', bg: 'bg-blue') %>" href="#">
  A styled button that is yellow instead of white, with a blue background
</a>

<!-- renders as:
<a class="f6 link dim ph3 pv2 mb2 dib white bg-black" href="#">
  A styled button
</a>
<a class="f6 link dim ph3 pv2 mb2 dib yellow bg-blue" href="#">
  A styled button that is yellow instead of white, with a blue background
</a>
-->
```

### Step 3 (optional): Tweak your style keys

The keys in the hash you pass to `Molecular.compound(styles)` determine which
CSS classes you can easily substitute later.

In the button from Step 2, it would be easy to swap `color` or `bg` for
different classes.

But if you wanted to replace any of the classes in the `base` key, you'd need to
rewrite the whole `base` key from scratch:

```erb
<a class="<%= Button.(base: 'f4 link dim ph3 pv2 mb2 dib') %>" href="#">
  This was an awful lot of work just to change the font size :(
</a>
```

To make a more flexible Compound, use more granular styles hash:

```ruby
Button = Molecular.compound(
  color: 'white',
  bg: 'black',
  size: 'f6',
  hover: 'link dim',
  padding: 'ph3 pv2',
  margin: 'mb2',
  display: 'dib',
)
```

```erb
<a class="<%= Button.(size: 'f3', padding: 'pa2', margin: nil) %>">
  This button was easier to tweak
</a>
```

---

## Usage (framework-specific)

If you skipped straight to this section from the TOC, make sure to read the
[generic usage section](#usage-generic) first!

These examples use Molecular and [tachyons.css][button] to style a button in
Rails, Sinatra, and Roda.

* [Rails](#rails)
* [Sinatra](#sinatra)
* [Roda](#roda)

### Rails

**Step 1:**

Import tachyons.css into your asset pipeline, either directly or via the
[tachyons-rails gem][tachyons-gem]

**Step 2:**

Create a `StyleHelper` in `app/helpers/style_helper.rb` and build some
compounds:

```ruby
module StyleHelper
  def ui_button
    Molecular.compound(
      color: 'white',
      bg: 'black',
      size: 'f6',
      hover: 'link dim',
      padding: 'ph3 pv2',
      margin: 'mb2',
      display: 'dib',
    )
  end
end
```

**Step 3:**

Use your StyleHelper methods in your views:

```erb
<!-- app/views/welcome/index.erb -->
<a class="<%= ui_button %>">A styled button</a>
<a class="<%= ui_button.(bg: 'bg-blue') %>">A blue button</a>
```

### Sinatra

**Step 1:**

Include the `tachyons.css` stylesheet somewhere in your app's layout.

**Step 2:**

Create a StyleHelper somewhere:

```ruby
module StyleHelper
  def ui_button
    Molecular.compound(
      color: 'white',
      bg: 'black',
      size: 'f6',
      hover: 'link dim',
      padding: 'ph3 pv2',
      margin: 'mb2',
      display: 'dib',
    )
  end
end
```

**Step 3:**

Make your StyleHelper available to your app's helper methods:

```ruby
require_relative 'wherever_you_put_it/style_helper'

class MyApp < Sinatra::Application
  helpers StyleHelper

  get '/' do
    erb :my_template
  end
end
```

**Step 4:**

Use your StyleHelper methods in your views:

```erb
<!-- views/my_template.erb -->
<a class="<%= ui_button %>">A styled button</a>
<a class="<%= ui_button.(bg: 'bg-blue') %>">A blue button</a>
```

### Roda

**Step 1:**

Include the `tachyons.css` stylesheet somewhere in your app's layout.

**Step 2:**

Create a StyleHelper somewhere:

```ruby
module StyleHelper
  def ui_button
    Molecular.compound(
      color: 'white',
      bg: 'black',
      size: 'f6',
      hover: 'link dim',
      padding: 'ph3 pv2',
      margin: 'mb2',
      display: 'dib',
    )
  end
end
```

**Step 3:**

Include StyleHelper in your app:

```ruby
require_relative 'wherever_you_put_it/style_helper'

class MyApp < Roda
  plugin :render
  include StyleHelper

  route do |r|
    get('/') { view('stylish') }
  end
end
```

**Step 4:**

Use your StyleHelper methods in your views:

```erb
<!-- views/stylish.erb -->
<a class="<%= ui_button %>">A styled button</a>
<a class="<%= ui_button.(bg: 'bg-blue') %>">A blue button</a>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/chrisfrank/molecular.

## Related Projects

* [Tachyons.css][tachyons]
* [Nanostyled (JS)](https://github.com/chrisfrank/nanostyled)

[tachyons]: http://tachyons.io/
[button]: http://tachyons.io/components/buttons/basic/index.html
[tachyons-rails]: https://github.com/maggy96/tachyons-rails
