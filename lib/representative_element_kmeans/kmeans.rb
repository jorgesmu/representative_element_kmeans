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

  	private

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
