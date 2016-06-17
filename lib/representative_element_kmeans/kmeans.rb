module RepresentativeElementKmeans
  class Kmeans
  	attr_reader :keys, :elements

  	def initialize(elements_map)
  		@keys = elements_map.keys
  		@elements = elements_map.values
  	end
  end
end
