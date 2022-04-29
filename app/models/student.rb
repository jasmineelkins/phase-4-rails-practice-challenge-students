class Student < ApplicationRecord
    belongs_to :instructor

    validates :name, presence: true
    validate :age_range

    def age_range
        if age < 18
            errors.add(:age, "Age out of range")
        end
    end
end
