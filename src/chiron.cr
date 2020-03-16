require "html-minifier"
require "css-minifier"
require "js-minifier"

module Chiron
  @@path : String = "."
  @@html_dir : String? = nil
  @@css_dir : String? = nil
  @@js_dir : String? = nil

  def self.load_project(@@path = ".")
    html_dir = Path[@@path].join("html").to_s
    css_dir = Path[@@path].join("css").to_s
    js_dir = Path[@@path].join("js").to_s
    @@html_dir = File.exists?(html_dir) ? html_dir : nil
    @@css_dir = File.exists?(css_dir) ? css_dir : nil
    @@js_dir = File.exists?(js_dir) ? js_dir : nil
    puts @@html_dir
    puts @@css_dir
    puts @@js_dir
  end
end

Chiron.load_project
