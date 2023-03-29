class User < ApplicationRecord
  devise :two_factor_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_defaults

  belongs_to :organization

  enum :role, %i(admin manager engineer qa basic)

  def manager_or_above?
    self.admin? || self.manager?
  end

  def otp_qr_code
    issuer = "TamsApp"
    label = "#{issuer}:#{email}"
    qrcode = RQRCode::QRCode.new(otp_provisioning_uri(label, issuer: issuer))
    qrcode.as_svg(module_size: 3)
  end

  private

  def set_defaults
    self.organization = Organization.first unless self.organization.present?
    self.role = User.roles[:basic] unless self.role.present?
  end
end
