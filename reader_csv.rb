module Readers
  module CSV
    def read_events file_name
      first_row = true
      names = []
      events = []
      CSV.foreach(file_name + ".csv") do |row|
        if first_row
          names = row
          first_row = false
        else
          event_hash = {}
          row.zip((0..(row.size - 1))).each do |field,position|
            field_name = names[position]
            if field_name == "date"
              event_hash[field_name] = Time.parse(field)
            elsif field_name == "complexity"
              event_hash[field_name] = field.to_f
            else
              event_hash[field_name] = field
            end
          end
          events << CodeEvent.new(event_hash)
        end
      end
      events
    end

  end
end
