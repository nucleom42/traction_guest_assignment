# frozen_string_literal: true

class Gov < ApplicationRecord
  enum gov_id_type: { ID: 'ID', DL: 'DL', SSN: 'SSN' }.freeze

  has_many :users
  
  validates :gov_id_type, uniqueness: true
end
