class Cinema < ApplicationRecord

    def as_json
        {
          id: id,
          name: name,
          location: location,
          brand:brand,
          studios:Studio.where(cinema_id:id)
        }
    end
end
