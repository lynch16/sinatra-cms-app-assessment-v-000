class Entity < ActiveRecord::Base
    validates :name, :type, :structure, presence: true

    belongs_to :loan
end
