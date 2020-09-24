require 'csv'

class HotdateCreate
    def self.create(hotdateTable)
        table = CSV.parse(File.read('../remarks.csv'), headers: true, quote_char: "|")
        table.sort { |a, b| a["id"].to_i <=> b["id"].to_i }
        table.each do |row|
            newRow = hotdateTable.create(
                name: row["name"],
                remark_type: row["type"].upcase,
                select_type: row["select_type"]
            )
            if newRow.valid?
                newRow.save
            end
        end
    end
end