json.code 200
json.data do
    json.id @updateCountry.id
    json.name @updateCountry.name
    json.iso_code @updateCountry.iso_code
    json.isd_code @updateCountry.isd_code
    json.description @updateCountry.description
    json.continent_id @updateCountry.continent_id
    json.continent_name @updateCountry.continent.name
end
json.msg "Updated Successfully"