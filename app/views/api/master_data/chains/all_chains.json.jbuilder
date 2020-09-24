json.code 200
json.data do
    json.array!(@chains) do |chain|
        json.id chain.id
        json.name chain.name
        json.description chain.description
        json.service_type_id chain.service_type_id
        json.master_chain_id chain.master_chain_id
        json.master_chain_name chain.master_chain.name
    end
end