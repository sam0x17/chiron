require "html-minifier"
require "css-minifier"
require "js-minifier"
require "file_utils"

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
    @ext_filter = ext_filter || ""
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
    add_layer "html", LayerType::HTML, "html|htm"
    add_layer "css", LayerType::CSS, "css"
    add_layer "js", LayerType::JavaScript, "js|json"
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
    raise "output directory #{output_dir} is not accessible!" unless Dir.exists?(output_dir)
    puts ""
    puts "discovering assets in #{@@path}..."
    actions = Array(Tuple(Layer, String)).new # layer, source file path
    layers.each do |layer|
      exts = layer.ext_filter.split("|").to_set
      puts " - #{layer.src_dir}"
      Dir.each_child(layer.src_dir) do |child|
        path = Path[layer.src_dir].join(child).to_s
        next unless exts.includes?(File.extname(path.downcase).gsub(".", ""))
        actions << {layer, path}
      end
    end
    actions = actions.shuffle
    groups = Array(Array(Tuple(Layer, String))).new
    num_groups = [System.cpu_count, actions.size].min
    num_groups.times { groups << Array(Tuple(Layer, String)).new }
    actions.each_with_index { |action, i| groups[i % num_groups] << action }
    puts ""
    puts "compiling #{actions.size} assets on #{num_groups} cores to #{output_dir}..."
    chan = Channel(Nil).new
    groups.each do |group|
      spawn do
        group.each do |action|
          layer, src_file_path = action
          dest_file_path = Path[output_dir].join(Path[layer.dest_dir].join(File.basename(src_file_path))).to_s
          FileUtils.mkdir_p(Path[output_dir].join(Path[layer.dest_dir]).to_s)
          case layer.type
          when LayerType::HTML
            data = File.read(src_file_path)
            minified = HtmlMinifier.minify!(data)
            File.write(dest_file_path, minified)
          when LayerType::CSS
            data = File.read(src_file_path)
            minified = CssMinifier.minify!(data)
            File.write(dest_file_path, minified)
          when LayerType::JavaScript
            data = File.read(src_file_path)
            minified = JsMinifier.minify!(data)
            File.write(dest_file_path, minified)
          when LayerType::Static
            FileUtils.cp(src_file_path, dest_file_path)
          when LayerType::Ignore
          end
          puts " - wrote #{dest_file_path}"
          chan.send(nil)
        end
      end
    end
    actions.size.times { chan.receive }
    puts ""
    puts "done."
    puts ""
  end
end

Chiron.load_project("scaffold/project_01")
Chiron.process!("/tmp/chiron")
