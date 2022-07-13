# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Gov, type: :model do
  describe '#valid' do
    context 'when gov_id_type already exists' do
      let(:gov) { build(:gov) }
      before { create(:gov) }

      it 'expects to be not valid' do
        expect(gov.valid?).to eq false
      end
    end
    
    context 'when gov_id_type is different from pre-set values' do
      let(:invalid_gov) { build(:gov, gov_id_type: 'SOMETHING NOT VALID') }
      
      it 'raises ArgumentError' do
        expect { invalid_gov }.to raise_error(ArgumentError)
      end
    end
  end
end
