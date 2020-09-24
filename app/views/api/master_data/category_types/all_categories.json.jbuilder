json.code 200
json.data do
    json.array!(@categories) do |category|
        json.id category.id
        json.name category.name
        json.description category.description
        json.service_type_id category.service_type_id
        json.service_type_name category.service_type.name
    end
end