require "./spec_helper"

describe Chiron do
  describe "layers" do
    it "identifies layers for a default project layout" do
      Chiron.load_project "./scaffold/project_01"
      Chiron.layers.size.should eq 3
      layers = Chiron.layers.sort_by { |layer| layer.type }
      layers[0].type.should eq Chiron::LayerType::HTML
      layers[1].type.should eq Chiron::LayerType::CSS
      layers[2].type.should eq Chiron::LayerType::JavaScript
      layers[0].dest_dir.should eq "html"
    end

    it "identifies css and html layers if js layer is missing" do
      Chiron.load_project "./scaffold/project_02"
      Chiron.layers.size.should eq 2
      layers = Chiron.layers.sort_by { |layer| layer.type }
      layers[0].type.should eq Chiron::LayerType::HTML
      layers[1].type.should eq Chiron::LayerType::CSS
    end

    it "identifies js layer if css and html layers are missing" do
      Chiron.load_project "./scaffold/project_03"
      Chiron.layers.size.should eq 1
      Chiron.layers.first.type.should eq Chiron::LayerType::JavaScript
    end

    it "allows for custom static layers" do
      Chiron.load_project "./scaffold/project_04"
      Chiron.add_layer! "images"
      Chiron.layers.size.should eq 4
      layers = Chiron.layers.sort_by { |layer| layer.type }
      layers[0].type.should eq Chiron::LayerType::HTML
      layers[1].type.should eq Chiron::LayerType::CSS
      layers[2].type.should eq Chiron::LayerType::JavaScript
      layers[3].type.should eq Chiron::LayerType::Static
      layers[3].dest_dir.should eq "images"
    end

    it "allows for custom static layers and missing default layers" do
      Chiron.load_project "./scaffold/project_05"
      Chiron.add_layer! "images"
      Chiron.layers.size.should eq 2
      layers = Chiron.layers.sort_by { |layer| layer.type }
      layers[0].type.should eq Chiron::LayerType::CSS
      layers[1].type.should eq Chiron::LayerType::Static
      layers[1].dest_dir.should eq "images"
    end
  end
end
