json.code 201
json.data do
    json.id @newAddon.id
    json.name @newAddon.name
    json.service_type_id @newAddon.service_type_id
    json.service_type_name @newAddon.service_type.name
end
json.msg "Created Addon Successfully"