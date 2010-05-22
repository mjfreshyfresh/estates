require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Estate
  
  def self.portland
    items = Estate.all
    items.collect{|item| (item.downcase.include?('portland') ? item : nil)}.compact    
  end
      
  #doc.xpath('//span[@class="style24"]', '//span[@class="style70"]').each do |link|
  #addresses << node.inner_html.gsub(/<\/?[^>]*>/, "")          
  def self.all
    doc = Nokogiri::HTML(open('http://www.estatesale-finder.com/salespage.htm'))
    addresses = []
    begin      
      doc.xpath('//p[@class="style24"]', '//p[@class="style70"]').each do |link|
        link.children.each do |node|
          if node.name == 'a'            
            lng_s = node['href'].split('q=')[1] unless node['href'].split('q=').nil?
            addresses << ( (lng_s != nil && lng_s.split('&sll=').size > 1) ? lng_s.split('&sll=')[0] : lng_s )
          end
        end              
      end
    rescue Exception => e
      puts e.inspect
    end    
    addresses.compact.uniq
  end
  
end