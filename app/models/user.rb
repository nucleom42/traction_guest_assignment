# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :gov

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :gov_id_number, uniqueness: { scope: [:first_name, :last_name, :email] }
end
