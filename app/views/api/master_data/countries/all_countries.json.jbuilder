json.code 200
json.data do
    json.array!(@countries) do |country|
        json.id country.id
        json.name country.name
        json.iso_code country.iso_code
        json.isd_code country.isd_code
        json.description country.description
        json.continent_id country.continent_id
        json.continent_name country.continent.name
    end
end