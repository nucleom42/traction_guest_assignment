require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:gov_id) { create(:gov, gov_id_type: 'ID') }
  let(:gov_ssn) { create(:gov, gov_id_type: 'SSN') }
  let(:fist_name_last_name_filters) { { first_name: 'name_1_id', last_name: 'last_name_1_id' } }
  let(:gov_id_type_filter) { { gov_id_type: 'ID' } }

  before do
    5.times do |i|
      create(:user, first_name: "name_#{i}_id", last_name: "last_name_#{i}_id", email: "test_id_#{i}@test.com",
             gov: gov_id, gov_id_number: "#{i}235-id-#{i}")
      create(:user, first_name: "name_#{i}_ssn", last_name: "last_name_#{i}_ssn", email: "test_ssn_#{i}@test.com",
             gov: gov_ssn, gov_id_number: "#{i}235-ssn-#{i}")
    end
  end

  describe "GET /user" do
    context 'when no params passed' do
      it 'returns ok' do
        get '/user'
        expect(response).to have_http_status :ok
      end
      
      it 'returns 10 records json' do
        get '/user'
        expect(JSON.parse(response.body).count).to eq 10
      end
    end

    context 'when params passed' do
      it 'returns ok' do
        get '/user', params: fist_name_last_name_filters
        expect(response).to have_http_status :ok
      end
      
      it 'returns filtered result' do
        get '/user', params: fist_name_last_name_filters
        expect(JSON.parse(response.body).count).to eq 1
      end
    end

    context 'when single result param passed' do
      context 'when result count is bigger than 1' do
        it 'returns bad_request' do
          get '/user', params: gov_id_type_filter.merge(single_result: true)
          expect(response).to have_http_status :bad_request
        end
      end

      context 'when result count is eq to 1' do
        it 'returns specific record json' do
          get '/user', params: fist_name_last_name_filters.merge(single_result: true)
          expect(JSON.parse(response.body).count).to eq 1
        end
      end
    end
  end
  
  describe "DELETE /user" do
    context 'when no params passed' do
      it 'returns bad request' do
        delete '/user'
        expect(response).to have_http_status :bad_request
      end
      
      it 'returns error too many records' do
        delete '/user'
        expect(JSON.parse(response.body)).to eq({"error" => "too many records"})
      end
    end
    context 'when params passed' do
      context 'no records found' do
        it 'returns no user found' do
          delete '/user', params: { email: 'notexisting@gg.com' }
          expect(response).to have_http_status :bad_request
        end

        it 'returns error no user found' do
          delete '/user', params: { email: 'notexisting@gg.com' }
          expect(JSON.parse(response.body)).to eq({"error" => "no user found"})
        end
      end
      
      context 'there are 1 record meet passed params found' do
        it 'returns ok' do
          delete '/user', params: { email: 'test_id_1@test.com' }
          expect(response).to have_http_status :ok
        end

        it 'returns ok response' do
          user_id = User.find_by(email: 'test_id_1@test.com').id
          delete '/user', params: { email: 'test_id_1@test.com' }
          expect(JSON.parse(response.body)).to eq({"ok" => user_id})
        end
      end


      context 'there are more than 1 record found' do
        it 'returns bad_request' do
          delete '/user', params: { gov_id_type: 'ID' }
          expect(response).to have_http_status :bad_request
        end

        it 'returns error response' do
          delete '/user', params: { gov_id_type: 'ID' }
          expect(JSON.parse(response.body)).to eq({"error" => "too many records"})
        end
      end
    end
  end
end
