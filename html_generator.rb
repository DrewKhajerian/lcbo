require 'rubygems'
require 'json'
require 'open-uri'

class HTMLGenerator

	#Displays full product list if specific product isn't specified
	def index(search=nil)
		product_array = []
		products = retrieve_data("http://lcboapi.com/products?q=#{search}")

		print_header

		puts "<h1>LCBO Product List</h1>"

		products.each do |product|
			puts "	<div class='product'>"
			puts "		<img src='#{product['image_thumb_url']}' class='product-thumb'/>"
			puts "		<h2>#{product['name']}</h2>" 
			puts "			<ul class='product-date'>"
			puts "				<li>ID: #{product['id']}</li>"
			puts "				<li>#{product['name']}</li>"
			puts "				<li>$#{format_price(product['price_in_cents'])}</li>"
			puts "				<li>Type: #{product['secondary_category']}</li>"
			puts "				<li>#{product['package']}</li>"
			puts "				<li>Alcohol content: #{product['alcohol_content']}</li>"
			puts "				<li>Price per/L of alcohol: $#{format_price(product['price_per_liter_of_alcohol_in_cents'])}</li>"
			puts "			</ul>"
			puts " 	</div>"
		end

		puts "<footer>Search a product ID for more information</footer>"
		print_footer

	end

	# display specific product using entered id
	def show(id)
		product = retrieve_data("http://lcboapi.com/products?q=#{id}")
		
		puts "	<div class='product'>"
		puts "		<img src='product['image_thumb_url']' class='product-thumb'/>"
		puts "		<h2>product['name']</h2>" 
		puts "			<ul class='product-date'>"
		puts "				<li>ID: product['id']</li>"
		puts "				<li>product['name']</li>"
		puts "				<li>$#{format_price(product['price_in_cents'])}</li>"
		puts "				<li>Type: product['secondary_category']</li>"
		puts "				<li>product['package']</li>"
		puts "				<li>Alcohol content: product['alcohol_content']</li>"
		puts "				<li>Price per/L of alcohol: $format_price(product['price_per_liter_of_alcohol_in_cents'])</li>"
		puts "			</ul>"
		puts " 	</div>"
		
		print_header

	end

	def print_header
		puts "<!DOCTYPE html>"
		puts "<html>"
		puts "	<head>"
		puts " 		<title>Find Your Favourite LCBO Products!</title>"
		puts "		<link rel='stylesheet' href='normalize.css' type='text/css'>"
    puts "    <link rel='stylesheet' href='style.css' type='text/css'>"
		puts "	</head>"
		puts "	<body>"
	end

	def print_footer
		puts "	</body>"
		puts "</html>"
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
		cents_string.to_f/100		
	end

end