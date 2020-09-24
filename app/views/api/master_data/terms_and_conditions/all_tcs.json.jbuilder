json.code 200
json.data do
    json.array!(@tcs) do |tc|
        json.id tc.id
        json.terms tc.terms
        json.from_market_id tc.from_market_id
        json.from_market_name tc.from_market.name
        json.to_market_id tc.to_market_id
        json.to_market_name tc.to_market.name
    end
end