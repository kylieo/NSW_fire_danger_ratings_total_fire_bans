# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

require 'scraperwiki'
require 'mechanize'

agent = Mechanize.new

# Read in a page
page = agent.get("http://www.rfs.nsw.gov.au/fire-information/fdr-and-tobans")

#name = page.at("table.danger-ratings-table tbody").search("tr").at("td").text

rows = page.at("table.danger-ratings-table tbody").search("tr")

rows.each do |row|
	name = row.search("td")[0].text

	today_fire_danger_rating = row.search("td")[1].text

	today_total_fire_ban = row.search("td")[2].text

	tomorrow_fire_danger_rating = row.search("td")[3].text

	tomorrow_total_fire_ban = row.search("td")[4].text

	councils_affected = row.search("td")[5].text

	record = {
	  name: name,
	  today_fire_danger_rating: today_fire_danger_rating,
	  today_total_fire_ban: today_total_fire_ban,
	  tomorrow_fire_danger_rating: tomorrow_fire_danger_rating,
	  tomorrow_total_fire_ban: tomorrow_total_fire_ban,
	  councils_affected: councils_affected
	}

p record 

	ScraperWiki.save_sqlite([:name], record)

end




# page.search(:h2).each do |item|
#   # get the text for the second paragraph in the item element
#   item.search(:p)[1].text
# end

# p name

# p today_fire_danger_rating

# p tomorrow_fire_danger_rating

# p councils_affected			

# p tomorrow_total_fire_ban			

# p today_total_fire_ban		



#
# # Write out to the sqlite database using scraperwiki library
# ScraperWiki.save_sqlite(["name"], {"name" => "susan", "occupation" => "software developer"})
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries.
# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".
