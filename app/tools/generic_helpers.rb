module GenericHelpers

    def make_hash_by_attribute(array, attribute)
        array.each_with_object({}) do |array_item, new_hash|
            new_hash[array_item.send("#{attribute}")].nil? ? new_hash[array_item.send("#{attribute}")] = 1 : new_hash[array_item.send("#{attribute}")] += 1
        end
    end


end
