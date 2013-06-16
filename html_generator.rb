require 'rubygems'
require 'json'
require 'open-uri'

class HTMLGenerator

	#Displays full product list if specific product isn't specified
	def index(search=nil)
		product_array = []
		products = retrieve_data("http://lcboapi.com/products?q=#{search}")

		print_header

		puts "<div class='whole-page'>"
		puts "<div class='container'>"
		puts "<img src='http://gelcommunications.com/wp-content/uploads/2011/02/lcbo.png' class='logo'>"
		puts "<h1>Product List</h1>"

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
			puts "				<li>Alcohol content: #{format_alc(product['alcohol_content'])}%</li>"
			puts "				<li><strong>Price per/L of alcohol: $#{format_price(product['price_per_liter_of_alcohol_in_cents'])}</strong></li>"
			puts "			</ul>"
			puts " 	</div>"
		end

		puts "<footer>Search a product ID for more information</footer>"
		print_footer

	end

	# display specific product using entered id
	def show(id)
		# id = id.to_i
		product = retrieve_data("http://lcboapi.com/products?q=#{id}")
		
		puts "	<div class='product'>"
		puts "		<img src='product['image_thumb_url']' class='product-thumb'/>"
		puts "		<h2>product['name']</h2>" 
		puts "			<ul class='product-data'>"
		puts "				<li>ID: product['id']</li>"
		puts "				<li>product['name']</li>"
		puts "				<li>$#{format_price(product['price_in_cents'])}</li>"
		puts "				<li>Type: product['secondary_category']</li>"
		puts "				<li>product['package']</li>"
		puts "				<li>Alcohol content: #{format_alc(product['alcohol_content'])}%</li>"
		puts "				<li><strong>Price per/L of alcohol: $format_price(product['price_per_liter_of_alcohol_in_cents'])</strong></li>"
		if product['is_discontinued']
			puts "        <li>On Sales!</li>"
			puts "				<li>Savings: $format_price(product['limited_time_offer_savings_in_cents'])</li>"
		end
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
		puts "	</div>"
		puts " 	</div>"
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

	def format_alc(content)
		content.to_f/100
	end

	def format_price(cents_string)
		cents_string.to_f/100		
	end

end