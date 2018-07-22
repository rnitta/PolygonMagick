require "PolygonMagick/version"
require "mini_magick"
require 'bigdecimal'
require 'bigdecimal/util'

module PolygonMagick
  class Image
    attr_accessor :image
    def initialize
      @image = MiniMagick::Image.open(File.expand_path('../PolygonMagick/img/blank.png', __FILE__))
    end

    def make(type, vertex = 3, radius = 100 , margin = 10)
      raise Exception if vertex < 3
      case type
      when :single
        single(vertex, radius, margin)
      when :multi
        multiple(vertex, radius, margin)
      end
    end

    def write(path)
      @image.write(path)
    end

    private

    def single(vertex, radius, margin)
      c_array = coordinates(vertex, radius, margin)
      size = 2 * (radius + margin)
      @image.resize("#{size}x#{size}")
      @image.combine_options do |c|
        c.fill 'black'
        c_array.each do |stroke|
          c.draw(stroke)
        end
        c.rotate(-90)
      end
    end

    def multiple(vertex, base_size, margin)
      c_array = (3..vertex).inject([]) { |array, n| array += coordinates(n, radius(n, base_size), radius(vertex, base_size) - radius(n, base_size) + margin) }
      size = 2 * (radius(vertex, base_size) + margin)
      @image.resize("#{size}x#{size}")
      @image.combine_options do |c|
        c.fill 'black'
        c_array.each do |stroke|
          c.draw(stroke)
        end
        c.rotate(-90)
      end
    end

    def circles

    end

    def coordinates(n, base_size, offset)
      r = base_size
      deg = Math::PI.to_d * 2 / n
      vertex = (0..n).map { |i| [r * (1 + Math.cos(deg * i).to_d) + offset, r * (1 + Math.sin(deg * i).to_d) + offset] }
      sides = []
      0.upto(vertex.length - 2) do |i|
        sides << (vertex[i] + vertex[i + 1]).map(&:round)
      end
      sides.map { |points| "line #{points[0]},#{points[1]} #{points[2]},#{points[3]}" }
    end

    def radius(n, base_size)
      @radius ||= []
      if @radius[n]
        @radius[n]
      else
        @radius[n] = n == 3 ? base_size : radius(n - 1, base_size) / Math.cos(Math::PI.to_d / n).to_d
      end
    end
  end
end
