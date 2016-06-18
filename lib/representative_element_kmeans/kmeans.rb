require 'k_means'
module RepresentativeElementKmeans
  class Kmeans
  	attr_reader :elements_map, :opts, :distance_measure


  	def initialize(elements_map, opts, &distance_measure)
  		@elements_map = elements_map
  		@opts = opts
      @distance = distance_measure
  		clusterize 
  	end

  	def centroids
  		@kmeans_manager.centroids
  	end

  	def clusters
  		clusters_by_domain keys
  	end
  	alias_method :clusters_by_ids, :clusters

  	def clusters_by_index
  		@kmeans_manager.view
  	end

  	def clusters_by_elements
  		clusters_by_domain elements
  	end

  	def representative_elements
  		representative_ids.map{|k| elements_map[k]}
  	end

  	def representative_ids
			find_representative_elements.map{|e| e[:element_key]}
  	end

  	def distance_to_representatives query
  		distances_to representative_elements, query
  	end

  	def distance_to_centroids query
  		distances_to centroids, query
  	end

  	def keys
  		elements_map.keys
  	end

  	def elements 
  		elements_map.values
  	end

  	private

  	def distances_to vector, query
  		vector.map do |v|
  			calculate_distance v, query
  		end
  	end

  	def find_representative_elements
  	  representative_elements = []
  		clusters_by_ids.each_with_index do |cluster, i|
  			distance = Float::INFINITY 
  			min_id = nil
  			cluster.each do |element_key|
  				distance_element_to_centroid = calculate_distance(centroids[i], elements_map[element_key]).to_f
  				if distance_element_to_centroid < distance
  					distance = distance_element_to_centroid
  					min_id = element_key
  				end
  			end
  			representative_elements.push({element_key: min_id, distance: distance})
  		end
  		representative_elements
  	end

		def calculate_distance(e1, e2)
      @distance.call e1, e2	
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
  		@kmeans_manager ||= KMeans.new(elements, @opts, &@distance)
  	end
  end
end
