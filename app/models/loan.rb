class Loan < ActiveRecord::Base
    validates :name, :number, :amount, presence: true

    has_many :entities
    belongs_to :user
end
