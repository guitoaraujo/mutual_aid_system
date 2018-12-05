class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  belongs_to :user, optional: true
  has_many :users
  has_many :orders
  
  before_create :set_token
  
  validates :name, :cpf, :phone, :mibank, :email, :password, :password_confirmation, presence: true
  validates :cpf, :email, :mibank, uniqueness: true
  
  enum status: [:inactive, :active, :blocked]
  
  def set_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
