require 'sinatra'
require 'httparty'
require './github.rb'
require 'haml'
require './parse.rb'

get '/' do
  haml :index
end

get '/times' do
  @max ||= 10
  @min ||= 1
  haml :table
end

post '/times' do
  @max = params[:max].to_i
  @min = params[:min].to_i
  haml :table
end

get '/letters' do
  haml :letter_count
end

post '/letters' do
  @words = params[:word]
  @number_of_letters = @words.gsub(" ", "").upcase.split("").inject(Hash.new(0)) do |hash,letter|
      hash[letter] += 1
      hash
    end
  haml :letter_count
end

get '/repos' do
  haml :repos
end

post '/repos' do
  @name = params[:github_name]
  @repos = Github.get("https://api.github.com/users/#{@name}/repos")
  haml :repos
end

get '/news' do
  tiy_atl = Parse.new('.title > a', 'http://atlanta.theironyard.com/')
  @tiy = tiy_atl.parsed
  @tiy_site = tiy_atl.site
  giz = Parse.new('header > h1 > a', 'http://www.gizmodo.com')
  @giz = giz.parsed
  @giz_site = giz.site
  my_blog = Parse.new('h1 > a', 'http://iamandrewhouse.com')
  @my_blog = my_blog.parsed
  @my_site = my_blog.site
  haml :news

end
