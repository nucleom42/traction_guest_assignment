# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :gov_id_number, :gov_id_type

  def gov_id_type
    object.gov.gov_id_type
  end
end
