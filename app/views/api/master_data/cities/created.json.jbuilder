json.code 201
json.data do
    json.id @newCity.id
    json.name @newCity.name
    json.airport_code @newCity.airport_code
    json.std_code @newCity.std_code
    json.description @newCity.description
    json.country_id @newCity.country_id
    json.country_name @newCity.country.name
end
json.msg "Created City Successfully"