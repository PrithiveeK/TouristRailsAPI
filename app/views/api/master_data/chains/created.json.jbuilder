json.code 201
json.data do
    json.id @newChain.id
    json.name @newChain.name
    json.description @newChain.description
    json.service_type_id @newChain.service_type_id
    json.master_chain_id @newChain.master_chain_id
    json.master_chain_name @newChain.master_chain_name
end
json.msg "Created Chain Successfully"