json.code 200
json.data do
    json.id @updateChain.id
    json.name @updateChain.name
    json.description @updateChain.description
    json.service_type_id @updateChain.service_type_id
    json.master_chain_id @updateChain.master_chain_id
    json.master_chain_name @updateChain.master_chain_name
end
json.msg "Updated Successfully"