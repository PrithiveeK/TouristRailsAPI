json.code 200
json.data do
    json.array!(@facilities) do |facility|
        json.id facility.id
        json.name facility.name
        json.description facility.description
        json.service_type_id facility.service_type_id
        json.service_type_name facility.service_type.name
    end
end