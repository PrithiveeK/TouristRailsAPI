json.code 201
json.data do
    json.id @newAmenity.id
    json.name @newAmenity.name
    json.description @newAmenity.description
    json.service_type_id @newAmenity.service_type_id
    json.service_type_name @newAmenity.service_type.name
end
json.msg "Created Amenity Successfully"