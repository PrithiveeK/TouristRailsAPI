json.code 201
json.data do
    json.id @newCategoryType.id
    json.name @newCategoryType.name
    json.description @newCategoryType.description
    json.service_type_id @newCategoryType.service_type_id
    json.service_type_name @newCategoryType.service_type.name
end
json.msg "Created CategoryType Successfully"