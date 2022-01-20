# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :role_assignments
  has_many :roles, through: :role_assignments

  has_many :products, foreign_key: :seller_id

  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end
end
