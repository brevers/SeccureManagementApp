class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_organization

  belongs_to :organization

  enum :role, %i(admin manager engineer qa)



  def manager_or_above?
    self.admin? || self.manager?
  end

  private

  def set_organization
    self.organization = Organization.first
  end
end
