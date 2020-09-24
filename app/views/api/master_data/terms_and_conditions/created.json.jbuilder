json.code 201
json.data do
    json.id @newTC.id
    json.terms @newTC.terms
    json.from_market_id @newTC.from_market_id
    json.from_market_name @newTC.from_market.name
    json.to_market_id @newTC.to_market_id
    json.to_market_name @newTC.to_market.name
end
json.msg "Created Terms and Conditions Successfully"