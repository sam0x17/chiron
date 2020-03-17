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
  end
end
