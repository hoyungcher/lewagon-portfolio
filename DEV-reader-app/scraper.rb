require 'open-uri'
require 'nokogiri'

class Scraper
  attr_reader :url, :name, :author, :content
  def initialize(url)
    @url = "https://dev.to/" + url
    @name = retrieve_name
    @author = retrieve_author
    @content = retrieve_content
  end

  def retrieve_name
    html_file = open(@url).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.css("h1[itemprop='name headline']").text.strip
  end

  def retrieve_author
    html_file = open(@url).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.css("span[itemprop='name']").text.strip
  end

  def retrieve_content
    html_file = open(@url).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.css("div#article-body.body").text.strip
  end
end
