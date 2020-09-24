json.code 201
json.data do
    json.id @newFacility.id
    json.name @newFacility.name
    json.description @newFacility.description
    json.service_type_id @newFacility.service_type_id
    json.service_type_name @newFacility.service_type.name
end
json.msg "Created Facility Successfully"