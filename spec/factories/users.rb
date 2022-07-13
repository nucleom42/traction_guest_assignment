# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'test' }
    last_name { 'test' }
    email { 'test@test.test' }
    gov_id_number { '12345' }
    gov
  end
end

