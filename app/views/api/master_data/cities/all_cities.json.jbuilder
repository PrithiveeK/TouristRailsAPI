json.code 200
json.data do
    json.array!(@cities) do |city|
        json.id city.id
        json.name city.name
        json.airport_code city.airport_code
        json.std_code city.std_code
        json.description city.description
        json.country_id city.country_id
        json.country_name city.country.name
    end
end