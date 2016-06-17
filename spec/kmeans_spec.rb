require 'spec_helper'

describe RepresentativeElementKmeans::Kmeans do
  let(:elements) { {"1" => [1,1,1], "2" => [1,2,3], "3" =>[3,2,10], "4" => [0,5,2]} }
  let(:kmeans) { RepresentativeElementKmeans::Kmeans.new elements }

  it 'not nil' do
    expect(kmeans).not_to eq nil 
  end

  it 'keys' do
    expect(kmeans.keys).to eq ["1", "2", "3", "4"]
  end

  it 'cluster_by_ids' do
  	kmeans.stub(:clusters_by_index).and_return([[0,2],[1],[3]])

  	expect(kmeans.clusters_by_ids).to eq [["1","3"],["2"],["4"]]
  	expect(kmeans.clusters_by_ids).to eq kmeans.clusters_by_ids
  end

  it 'clusters_by_elements' do
  	kmeans.stub(:clusters_by_index).and_return([[0,2],[1],[3]])
  	expect(kmeans.clusters_by_elements).to eq [[elements["1"],elements["3"]],[elements["2"]], [elements["4"]]]
  end
end
