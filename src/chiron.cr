require "html-minifier"
require "css-minifier"
require "js-minifier"

enum Chiron::LayerType
  HTML
  JavaScript
  CSS
  Static
  Ignore
end

struct Chiron::Layer
  property src_dir : String
  property type : LayerType
  property dest_dir : String # relative to project root

  def initialize(src_dir, @type, dest_dir = nil)
    @src_dir = Path[Chiron.project_path].join(src_dir).to_s
    @dest_dir = dest_dir.nil? ? File.basename(src_dir) : dest_dir
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
    begin; add_layer "html", LayerType::HTML; rescue; end;
    begin; add_layer "css", LayerType::CSS; rescue; end;
    begin; add_layer "js", LayerType::JavaScript; rescue; end;
  end

  def self.add_layer(src_dir : String, type : LayerType = LayerType::Static, dest_dir : String? = nil)
    layer = Layer.new(src_dir, type, dest_dir)
    raise "source directory #{layer.src_dir} for new layer could not be found!" unless Dir.exists?(layer.src_dir)
    @@layers << layer
    true
  end
end

Chiron.load_project("./scaffold/project_01")
pp Chiron.layers

