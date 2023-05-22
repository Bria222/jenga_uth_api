class User < ApplicationRecord
    validates :name, presence: true
    validates :email, uniqueness: true, presence: true
    validates :password,  presence: true
    validates :phone_number, presence: true, numericality: { only_integer: true }, length: { is: 13 }
    def admin?
     role == "admin"
    end

    def supplier?
      role == "supplier"
    end

end
