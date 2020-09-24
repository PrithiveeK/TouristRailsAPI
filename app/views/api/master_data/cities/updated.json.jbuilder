json.code 200
json.data do
    json.id @updateCity.id
    json.name @updateCity.name
    json.airport_code @updateCity.airport_code
    json.std_code @updateCity.std_code
    json.description @updateCity.description
    json.country_id @updateCity.country_id
    json.country_name @updateCity.country.name
end
json.msg "Updated Successfully"