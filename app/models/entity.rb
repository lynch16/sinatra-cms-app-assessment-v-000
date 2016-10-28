class Entity < ActiveRecord::Base
    validates :name, :entity_type, :structure, presence: true

    belongs_to :loan
end
