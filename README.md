# PolygonMagick

## Summary

Generate polygon(s) PNG image using ImageMagick.

This is made just for me.

## Requirement

- ImageMagick

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'PolygonMagick'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install PolygonMagick

## Usage


```
require 'PolygonMagick'

img = PolygonMagick::Image.new
img.make(:single, 8)
img.write('polygon.png')
```
![single_8](https://user-images.githubusercontent.com/31783570/43050718-df31f38a-8e48-11e8-83a3-52667b6c7e64.png)

```
require 'PolygonMagick'

img = PolygonMagick::Image.new
img.make(:multi, 100)
img.write('polygon.png')
```
![multi_100](https://user-images.githubusercontent.com/31783570/43050719-df59838c-8e48-11e8-80d5-bed32a307785.png)


## Contributing

As you like
