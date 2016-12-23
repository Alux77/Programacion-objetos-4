require 'nokogiri'

@doc = Nokogiri::XML(File.open("twitter_account.html"))
@doc.xpath("//character")