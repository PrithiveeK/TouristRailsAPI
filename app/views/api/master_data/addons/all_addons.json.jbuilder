json.code 200
json.data do
    json.array!(@addons) do |addon|
        json.id addon.id
        json.name addon.name
        json.service_type_id addon.service_type_id
        json.service_type_name addon.service_type.name
    end
end