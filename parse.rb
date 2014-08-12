require 'nokogiri'
require 'open-uri'

class Parse

	attr_reader :site

	def initialize (css, site)
		@css = css
		@data = []
		@site = site
	end

	def parsed
    page = Nokogiri::HTML(open(@site))
    page.css(@css).each do |el|
      @data.push([el.text, el['href']])
    end
    @data
	end

end
