json.code 201
json.data do
    json.id @newCountry.id
    json.name @newCountry.name
    json.iso_code @newCountry.iso_code
    json.isd_code @newCountry.isd_code
    json.description @newCountry.description
    json.continent_id @newCountry.continent_id
    json.continent_name @newCountry.continent.name
end
json.msg "Created Country Successfully"