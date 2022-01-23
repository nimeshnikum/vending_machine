# frozen_string_literal: true
class User < ActiveRecord::Base
  DEPOSIT_OPTIONS = [5, 10, 20, 50, 100].freeze

  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :role_assignments
  has_many :roles, through: :role_assignments

  has_many :products, foreign_key: :seller_id
  has_many :deposits, foreign_key: :buyer_id
  has_many :orders, foreign_key: :buyer_id

  #TODO
  accepts_nested_attributes_for :roles

  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end

  def add_deposit!(coin_value)
    if DEPOSIT_OPTIONS.include?(coin_value)
      increment!(:deposit, coin_value)
    else
      errors.add(:deposit, "is invalid") and false
    end
  end

  def reset_deposit!
    update(deposit: 0)
  end
end
