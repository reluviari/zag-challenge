#!/usr/bin/env ruby

require 'open-uri'
require 'json'
require 'nokogiri'

class Crawler
  attr_reader :uri

  def self.cli(args, io = $stdout)
    if args.size != 1
      err.puts "Infome a URL. Exemplo: $ ruby crawler.rb http://dominio.com.br"
      exit 1
    end

    crawler = new(args[0])
    response_crawler = crawler.crawl!
    $stdout.puts JSON.pretty_generate(response_crawler)
    generate_json_response_crawler(response_crawler)
  end
  
  def initialize(url)
    @url = url
    @uri = URI.parse(url)
  end

  def crawl!
    html = response_doc(@url)
    pages = html.css(%{a}).map{ |node| node["href"] }.compact.map{|l| parse_url(l) }.compact.map(&:to_s).uniq.sort
    response = pages.map do |page_url|
      parse_page(page_url)
    end
  end

  def response_doc(html)
    Nokogiri::HTML(open(html))
  end

  def parse_url(url)
    uri = @uri.merge(url)
    return nil if uri.host != @uri.host
    uri
  rescue URI::InvalidURIError
    return nil
  end

  def parse_page(page_url)
    html = response_doc(page_url)
    {
      page:   page_url,
      links:  html.css(%{a}).map{|node| node["href"]}.compact.map{|l|parse_url(l)}.compact.map(&:to_s).uniq.sort,
      css:    html.css(%{link[type="text/css"]}).map{|node| node["href"]}.compact,
      js:     html.css(%{script}).map{|node| node["src"] }.compact,
      images: html.css(%{img}).map{|node| node["src"] }.compact
    }
  end

  def self.generate_json_response_crawler(response_crawler)
    File.open( 'response_crawler.json', 'w') do |file|
      file.puts JSON.pretty_generate(response_crawler)
    end
  end

end 

require 'bundler'
Bundler.require
Crawler.cli($*)
