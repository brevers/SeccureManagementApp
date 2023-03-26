class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_defaults

  belongs_to :organization

  enum :role, %i(admin manager engineer qa basic)

  def manager_or_above?
    self.admin? || self.manager?
  end

  private

  def set_defaults
    self.organization = Organization.first unless self.organization.present?
    self.role = User.roles[:basic] unless self.role.present?
  end
end
