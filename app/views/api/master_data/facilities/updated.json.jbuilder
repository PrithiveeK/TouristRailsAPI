json.code 200
json.data do
    json.id @updateFacility.id
    json.name @updateFacility.name
    json.description @updateFacility.description
    json.service_type_id @updateFacility.service_type_id
    json.service_type_name @updateFacility.service_type.name
end
json.msg "Updated Successfully"