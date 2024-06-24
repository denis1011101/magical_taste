require 'nokogiri'
require 'open-uri'
require 'csv'

namespace :db do
  desc "Parse web page and save data to the database"
  task parse: :environment do
    doc = Nokogiri::HTML(open("http://example.com"))

    doc.css('.mix').each do |mix_node|
      name = mix_node.css('.name').text
      description = mix_node.css('.description').text

      Mix.create!(name: name, description: description)
    end
  end

  desc "Parse CSV file and save data to the database"
  task parse_csv: :environment do
    CSV.foreach(Rails.root.join('lib', 'tasks', 'mixes.csv'), headers: true) do |row|
      Mix.create!(name: row['name'], description: row['description'])
    end
  end
end
