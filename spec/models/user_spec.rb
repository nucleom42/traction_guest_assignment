# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'when email is invalid' do
      let(:user) { build(:user, email: 'not an email') }

      it 'returns false' do
        expect(user.valid?).to eq false
      end
    end

    context 'when record with same fields already created' do
      let(:gov) { create(:gov) }
      let(:user) { build(:user, gov: gov) }
      before { create(:user, gov: gov) }

      it 'returns false' do
        expect(user.valid?).to eq false
      end
    end
  end
end
