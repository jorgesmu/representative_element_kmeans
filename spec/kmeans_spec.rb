require 'spec_helper'

describe RepresentativeElementKmeans::Kmeans do
  let(:elements) { {"1" => [1], "2" => [2], "3" =>[3]} }
  let(:kmeans) { RepresentativeElementKmeans::Kmeans.new elements }

  it 'not nil' do
    expect(kmeans).not_to eq(nil)
  end

  it 'keys' do
    expect(kmeans.keys).to eq(elements.keys)
  end

  it 'elements' do
    expect(kmeans.elements).to eq(elements.values)
  end
end
