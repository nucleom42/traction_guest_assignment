# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Filterer, type: :service do
  describe '#call' do
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

    context 'when no args passed' do
      it 'returns 10 records' do
        expect(Users::Filterer.new.call.size).to eq 10
      end
    end

    context 'when user filter args passed' do
      it 'returns records with first_name name_1_id' do
        expect(Users::Filterer.new(user: fist_name_last_name_filters).call.last.first_name).to eq 'name_1_id'
      end

      it 'returns records with last_name last_name_1_id' do
        expect(Users::Filterer.new(user: fist_name_last_name_filters).call.last.last_name).to eq 'last_name_1_id'
      end
    end

    context 'when gov filter args passed' do
      it 'returns records with gov_type_id eq to ID' do
        expect(Users::Filterer.new(gov: gov_id_type_filter).call.all? { |u| u.gov.gov_id_type == 'ID' }).to eq true
      end
    end

    context 'when both filter args passed' do
      it 'returns requested record' do
        expect(Users::Filterer.new(gov: gov_id_type_filter, user: fist_name_last_name_filters).call.last)
          .to eq User.find_by(first_name: 'name_1_id')
      end
    end

    context 'when single_request filter passed' do
      context 'when result count is bigger then 1' do
        it 'raises TooManyRecords error' do
          expect { Users::Filterer.new(gov: gov_id_type_filter, single_result: true).call }
            .to raise_error Users::Filterer::TooManyRecords, 'too many records'
        end
      end

      context 'when result count is 1' do
        it 'returns a specific record' do
          expect(expect(Users::Filterer.new(gov: gov_id_type_filter, user: fist_name_last_name_filters).call.last)
                   .to eq User.find_by(first_name: 'name_1_id'))
        end
      end
    end
  end
end
