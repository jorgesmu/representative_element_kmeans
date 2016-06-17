require 'k_means'

module RepresentativeElementKmeans
  class Kmeans
  	attr_reader :keys, :elements


  	def initialize(elements_map, opts={})
  		@keys = elements_map.keys
  		@elements = elements_map.values
  		@opts = opts
  		clusterize 
  	end

  	def centroids
  		@kmeans_manager.centroids
  	end

  	def clusters
  		clusters_by_domain @keys
  	end
  	alias_method :clusters_by_ids, :clusters

  	def clusters_by_index
  		@kmeans_manager.view
  	end

  	def clusters_by_elements
  		clusters_by_domain @elements
  	end

  	def representative_elements
  		representative_elements = []
  		clusters_by_elements.each_with_index do |cluster, i|
  			centroid = centroids[i]
  			distance = Float::INFINITY 
  			min_element = nil
  			cluster.each do |element|
  				distance_element_to_centroid = euclidean(centroid, element).to_f
  				if distance_element_to_centroid < distance
  					distance = distance_element_to_centroid
  					min_element = element
  				end
  			end
  			representative_elements.push min_element
  		end
  		representative_elements
  	end

  	private

		def euclidean(e1, e2)
			sum = 0
			e1.zip(e2).each do |c1, c2|
			  component = (c1 - c2)**2
			  sum += component
			end
			Math.sqrt(sum)	
		end

  	def clusters_by_domain domain_elements
	  	clusters_by_index.map do |cluster|
	  		cluster.map do |element_index|
	  			domain_elements[element_index]
	  		end
	  	end
    end

  	def clusterize
			cluster_manager
  	end

  	def cluster_manager
  		@kmeans_manager ||= KMeans.new(@elements, @opts)
  	end
  end
end
