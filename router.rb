require_relative 'html_generator'

class Router	

	if ARGV.empty?
		puts "Improper use! usage: ruby router.rb [action]"
	else
		action = ARGV[0]
		generator = HTMLGenerator.new
	end

	if action == 'index'
		if ARGV[1] == nil # optional args def index(id=nil)
			generator.index()
		else
			search_item = ARGV[1]
			generator.index(search_item)
		end
	elsif action == "show"
		id = ARGV[1]
		generator.show(id)
		# puts "Unkown action! Usage: ruby router.rb [action] [args]"
	end


end