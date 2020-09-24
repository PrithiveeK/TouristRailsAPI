json.code 200
json.data do
    json.array!(@amenities) do |amenity|
        json.id amenity.id
        json.name amenity.name
        json.description amenity.description
        json.service_type_id amenity.service_type_id
        json.service_type_name amenity.service_type.name
    end
end