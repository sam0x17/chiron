require "html-minifier"
require "css-minifier"
require "js-minifier"

enum Chiron::LayerType
  HTML
  CSS
  JavaScript
  Static
  Ignore
end

class Chiron::Layer
  property src_dir : String
  property type : LayerType
  property dest_dir : String
  property ext_filter : String

  def initialize(src_dir, @type, dest_dir = nil, ext_filter = nil)
    @src_dir = Path[Chiron.project_path].join(src_dir).to_s
    @dest_dir = dest_dir.nil? ? File.basename(src_dir) : dest_dir
    @ext_filter = ext_filter || "*"
  end
end

module Chiron
  @@path : String = "."
  @@layers : Array(Layer) = Array(Layer).new
  @@registered_layer_paths : Set(String) = Set(String).new

  def self.project_path : String
    @@path
  end

  def self.layers
    @@layers
  end

  def self.load_project(@@path = ".")
    @@layers.clear
    @@registered_layer_paths.clear
    add_layer "html", LayerType::HTML, "*.html|*.htm"
    add_layer "css", LayerType::CSS, "*.css"
    add_layer "js", LayerType::JavaScript, "*.js|*.json"
  end

  def self.add_layer!(src_dir : String, type : LayerType = LayerType::Static, ext_filter : String? = nil, dest_dir : String? = nil)
    layer = Layer.new(src_dir, type, dest_dir, ext_filter)
    raise "source directory #{layer.src_dir} for new layer could not be found!" unless Dir.exists?(layer.src_dir)
    @@layers << layer
    true
  end

  def self.add_layer(src_dir : String, type : LayerType = LayerType::Static, ext_filter : String? = nil, dest_dir : String? = nil)
    begin
      return add_layer!(src_dir, type, ext_filter, dest_dir)
    rescue
    end
  end

  def self.process!(output_dir : String)
    puts ""
    puts "compiling assets in #{@@path}..."
    puts ""
    actions = Array(Tuple(Layer, String)).new # layer, source file path
    groups = Array(Array(Tuple(Layer, String))).new
    System.num_cpus.times { groups << Array(Tuple(Layer, String)).new }
    layers.each do |layer|
      Dir.each_child(Path[@@path].join(layer.src_dir)) do |child|
        
      end
    end
  end
end
