require 'nokogiri'
require 'uri'
require 'net/http'

class Page
  def initialize(url)
    @urls = url
    @url = Net::HTTP.get(URI(url))
    @page = Nokogiri::HTML(@url)
  end

  def fetch!
    puts "#{@urls}"
    puts "Fetching..."
    puts "Título: #{@title}"
    links  
  end

  def links
     home = @page.css(".container > nav.main-nav.navbar-right > div.navbar-collapse.collapse > ul.nav.navbar-nav > li.active.nav-item > a")[0]["href"]
     faq = @page.css(".nav-item > a")[3]["href"]
     blog = @page.css(".nav-item > a")[4]["href"]
     precios = @page.css(".nav-item > a")[5]["href"]
     escribenos = @page.css(".nav-item > a")[6]["href"]
     facebook = @page.css(".nav-item > a")[0]["href"]
     twitter = @page.css(".nav-item > a")[1]["href"]
     puts "Links: "
     puts "Facebook: #{facebook}"
     puts "Twitter: #{twitter}"
     puts "Home: #{home}"
     puts "Preguntas Frecuentes: #{faq}"
     puts "Blog: #{blog}"
     puts "Precios: #{precios}"
     puts "Escribenos: #{escribenos}"

  end

  def title
    @title =  @page.title
  end
end

class Browser
  def run!
    url = gets.chomp 
    while url == "http://www.codea.mx/"
     Page.new(url).fetch!
     url = gets.chomp 
    end
  end
end

browser = Browser.new.run!
p browser
