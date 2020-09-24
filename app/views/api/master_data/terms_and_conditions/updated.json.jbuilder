json.code 200
json.data do
    json.id @updateTC.id
    json.terms @updateTC.terms
    json.from_market_id @updateTC.from_market_id
    json.from_market_name @updateTC.from_market.name
    json.to_market_id @updateTC.to_market_id
    json.to_market_name @updateTC.to_market.name
end
json.msg "Updated Successfully!"