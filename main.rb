require 'json'
file_path = "assets/api-lannuaire-administration.json"

json_data = File.read(file_path)
data = JSON.parse(json_data)
departments = ['16', '24', '33', '31', '32', '64', '65', '79', '86']
key_words = ['culture', 'culturelle', 'culturel', 'art', 'communication', 'arts', 'bibliothèque', 'bibliothèques']
data.each do |administration|
  if administration['adresse']
    address_array = JSON.parse(administration['adresse'])
    code_postal = address_array.find do |code|
      departments.any? { |departement| code['code_postal'].start_with?(departement) }
    end
    if administration['mission'] && code_postal
      email = administration['adresse_courriel']
      mission_words = administration['mission'].downcase.split(/\W+/)
      matching_keywords_mission = mission_words.select { |word| key_words.include?(word) }
      if email
        email_words = email.downcase.split(/\W+/)
        matching_keywords_email = email_words.select { |word| key_words.include?(word) }
        if !matching_keywords_email.empty?
          puts email
          # puts administration['mission']
          # puts code_postal['code_postal']
          # puts "- - - - - - - - - -"
        end
      end
    end
  end
end