require 'uri'

class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
		rules = {
			" must contain at least one lowercase letter"  => /[a-z]+/,
			" must contain at least one uppercase letter"  => /[A-Z]+/,
			" must contain at least one digit"             => /\d+/,
			" must contain at least one special character" => /[!@#$%^&*]+/
		}

		rules.each do |message, regex|
			record.errors.add( attribute, message ) unless value.nil? || value.match( regex )
		end
  end
end

class User < ApplicationRecord
	has_many :referrals, dependent: :destroy

	attribute :balance, :decimal, default: 0.0

	validates :name, length: {maximum: 100}, presence: true
	validates :email, length: {maximum: 255}, presence: true, uniqueness: { case_sensitive: false }, 
						format: { with: URI::MailTo::EMAIL_REGEXP }, on: :create
	validates :password, length: {minimum: 8, maximum: 20}, presence: true, password: true

	validates_associated :referrals
end