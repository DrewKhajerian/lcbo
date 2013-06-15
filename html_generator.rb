require 'rubygems'
require 'json'
require 'open-uri'

class HTMLGenerator

	#Displays full product list if specific product isn't specified
	def index(search=nil)
		product_array = []
		products = retrieve_data("http://lcboapi.com/products?q=#{search}")

		products.each do |products|
			puts "	<div img=#{product['image_url']}</div>"
			puts "		<h3>Displaying all #{search} Products"
			puts "			<ul>"
			puts "				<li>#{product['id']}</li>"
			puts "				<li>#{product['name']}</li>"
			puts "				<li>#{format_price(product['price_in_cents']})</li>"
			puts "				<li>#{product['primary_category']}</li>"
			puts "				<li>#{product['secondary_category']}</li>"
			puts "				<li>#{product['package']}</li>"
			puts "				<li>#{product['package_unit_volume_in_milieters']}</li>"
			puts "				<li>#{product['total_package_units']}</li>"
			puts "				<li>#{product['alcohol_content']}</li>"
			puts "				<li>#{product['price_per_liter_of_alcohol_in_cents']}</li>"
			puts "				<li>#{product['image_thumb_ur']}</li>"
			puts "				<li></li>"
			puts "			</ul>"
			puts " 	</div>"
		end

	end

	# display specific product using entered id
	def show(id)
		#if id is not valid, display error message
		products = (open("http://lcboapi.com/products"))
		#use id to find and return specific product index
		index = products.index do |product|
			if product["id"] == id
		end
	end

	def print_header
		puts "<header>"
		puts " <h1>Find Your Favourite LCBO Products!</h1>"
		puts "</header>"
	end

	def print_footer

	end

	def retrieve_data(url)
		# Retrieve JSON-formatted text from lcboapi.com
    raw_response = open(url).read

    # Parse JSON-formatted text into a Ruby Hash
    parsed_response = JSON.parse(raw_response)

    # Return just the actual result data from the response, ignoring metadata
    result = parsed_response["result"]
	end

	def format_price(cents_string)
		cents_string.to_f * 0.01		
	end

end