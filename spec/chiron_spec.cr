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
    end

    it "identifies css and html layers if js layer is missing" do
      Chiron.load_project "./scaffold/project_02"
      Chiron.layers.size.should eq 2
      layers = Chiron.layers.sort_by { |layer| layer.type }
      layers[0].type.should eq Chiron::LayerType::HTML
      layers[1].type.should eq Chiron::LayerType::CSS
    end
  end
end
