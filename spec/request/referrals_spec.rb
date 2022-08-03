require 'rails_helper'

RSpec.describe ' Referrals API', type: :request do
  let(:admin) { FactoryBot.create(:role, name: 'admin') }
  let(:role_user) { FactoryBot.create(:role, name: 'user') }
  let(:role_ta) { FactoryBot.create(:role, name: 'ta') }

  describe '#Index' do
    before do
      ta_user = FactoryBot.create(:user, role_id: role_ta.id)
      regular_user = FactoryBot.create(:user, role_id: role_user.id)
      FactoryBot.create(:referral,
        referred_by: regular_user.id,
        linkedin_url: 'https://linkedin.com/example.1',
        tech_stack: 'ruby, RoR',
        ta_recruiter: ta_user,
        signed_date: Time.now
      )
      FactoryBot.create(:referral,
        referred_by: ta_user.id,
        linkedin_url: 'https://linkedin.com/example.2',
        tech_stack: 'ruby, RoR, ',
        ta_recruiter: ta_user,
        signed_date: Time.now
      )
      FactoryBot.create(:referral,
        referred_by: ta_user.id,
        linkedin_url: 'https://linkedin.com/example.3',
        tech_stack: 'ruby, RoR, ',
        ta_recruiter: ta_user,
        signed_date: Time.now,
        active: false
      )
    end
    context 'When call referral index enpoint' do
      it 'returns all the active referrals' do
        get '/referrals'

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(2)
      end
    end
  end
end
