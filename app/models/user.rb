class User < ActiveRecord::Base
  before_save :encrypt_password!

  ROLE_ADMIN = 1
  ROLE_USER  = 2
  ROLE_GUEST = 3

  def auth?(password)
    self.password == encrypted(password)
  end

  def is_a?(role)
    self.role <= role
  end

  private
  def encrypt_password!
    self.password = encrypted(self.password)
  end

  def encrypted(password)
    Digest::MD5.hexdigest(password)
  end
end
