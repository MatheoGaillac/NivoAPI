require 'json'
file_path = "assets/api-lannuaire-administration.json"

json_data = File.read(file_path)
data = JSON.parse(json_data)
departments = ['16', '24', '33', '31', '32', '64', '65', '79', '86']

data.each do |administration|
  if administration['adresse']
    address_array = JSON.parse(administration['adresse'])
    code_postal = address_array.find do |code|
      departments.any? { |department| code['code_postal'].start_with?(department) }
    end
    puts code_postal
  end
end
