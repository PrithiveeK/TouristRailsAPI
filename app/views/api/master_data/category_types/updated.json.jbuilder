json.code 200
json.data do
    json.id @updateCategoryType.id
    json.name @updateCategoryType.name
    json.description @updateCategoryType.description
    json.service_type_id @updateCategoryType.service_type_id
    json.service_type_name @updateCategoryType.service_type.name
end
json.msg "Updated Successfully"