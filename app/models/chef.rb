class Chef < ApplicationRecord
    before_save {self.email = email.downcase}
    validates :chefname, presence: true, length: { maximum: 30 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                                format: { with: VALID_EMAIL_REGEX },
                                uniqueness: { case_sensitive: false } #case insensitive là chữ hoa chữ thường ko phân biệt
                                
    has_many :recipes, dependent: :destroy           #nếu chef destroy thì recipes cũng destroy theo
    has_secure_password
    validates :password, presence: true, length: { minimum: 5 }
    has_many :comments, dependent: :destroy         #nếu chef destroy thì comments cũng destroy theo
end