json.code 200
json.data do
    json.id @updateAmenity.id
    json.name @updateAmenity.name
    json.description @updateAmenity.description
    json.service_type_id @updateAmenity.service_type_id
    json.service_type_name @updateAmenity.service_type.name
end
json.msg "Updated Successfully"