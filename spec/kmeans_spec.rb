require 'spec_helper'

describe RepresentativeElementKmeans::Kmeans do
  let(:elements) { 
                    {"1" => [1,1,1],
                     "2" => [1,2,3], 
                     "3" =>[3,2,10], 
                     "4" => [0,5,2],
                     "5" => [1,4,5]
                    }
                 }

  let(:kmeans) { RepresentativeElementKmeans::Kmeans.new elements }

  it 'not nil' do
    expect(kmeans).not_to eq nil 
  end

  it 'keys' do
    expect(kmeans.keys).to eq ["1", "2", "3", "4", "5"]
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

  it 'representative_elements' do
    kmeans.stub(:clusters_by_index).and_return([[0,2],[1,4],[3]])
    kmeans.stub(:centroids).and_return([[1,2,4], [4,5,3], elements["4"] ])
    expect(kmeans.representative_elements).to eq [elements["1"],elements["5"], elements["4"]]
  end

  it 'representative_ids' do
    kmeans.stub(:clusters_by_index).and_return([[0,2],[1,4],[3]])
    kmeans.stub(:centroids).and_return([[1,2,4], [4,5,3], elements["4"] ])
    expect(kmeans.representative_ids).to eq ["1", "5", "4"]
  end

  it 'distance_to_centroids' do
    kmeans.stub(:centroids).and_return([[1,2,4], [4,5,3], [2,3,4] ])
    expect(kmeans.distance_to_centroids([1,1,1])).to eq [3.1622776601683795, 5.385164807134504, 3.7416573867739413]
  end

  it 'distance_to_representive_elements' do
    kmeans.stub(:clusters_by_index).and_return([[0,2],[1,4],[3]])
    kmeans.stub(:representative_elements).and_return([[1,2,5], [11,3,3], [2,32,4] ])
    expect(kmeans.distance_to_representatives([1,1,1])).to eq [4.123105625617661, 10.392304845413264, 31.160872901765767]
  end
end
