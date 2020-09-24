json.code 200
json.data do
    json.id @updateAddon.id
    json.name @updateAddon.name
    json.service_type_id @updateAddon.service_type_id
    json.service_type_name @updateAddon.service_type.name
end
json.msg "Updated Successfully"