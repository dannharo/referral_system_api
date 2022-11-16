describe 'Referrals API', type: :request do
  let(:admin_role) { FactoryBot.create(:role, :role_admin) }
  let(:user_role) { FactoryBot.create(:role, :role_user) }
  let(:ta_role) { FactoryBot.create(:role, :role_ta) }
  let(:ta_user) { FactoryBot.create(:user, role_id: ta_role.id) }
  let(:regular_user) { FactoryBot.create(:user, role_id: user_role.id) }

  describe '#index' do
    context 'when active referrals exist' do
      before do
        FactoryBot.create(:referral,
          referred_by: regular_user.id,
          tech_stack: 'ruby, RoR',
          ta_recruiter: ta_user.id,
          signed_date: Time.now
        )

        FactoryBot.create(:referral,
          referred_by: ta_user.id,
          linkedin_url: 'https://linkedin.com/example.2',
          tech_stack: 'ruby, RoR, ',
          ta_recruiter: ta_user.id,
          signed_date: Time.now
        )

        FactoryBot.create(:referral,
          referred_by: ta_user.id,
          linkedin_url: 'https://linkedin.com/example.3',
          tech_stack: 'ruby, RoR, ',
          ta_recruiter: ta_user.id,
          signed_date: Time.now,
          active: false
        )
      end
      it 'returns all the active referrals' do
        get api_v1_referrals_url

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(2)
      end
    end

    context 'when there are no active referral' do
      before do
        FactoryBot.create(:referral,
                          referred_by: ta_user.id,
                          linkedin_url: 'https://linkedin.com/example.3',
                          tech_stack: 'ruby, RoR, ',
                          ta_recruiter: ta_user.id,
                          signed_date: Time.now,
                          active: false
        )
      end
      it 'returns empty response' do
        get api_v1_referrals_url

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(0)
      end
    end
  end

  describe '#create' do
    context 'with valid data' do
      let(:data_referral) do
        {
          full_name: Faker.name,
          referred_by: regular_user.id,
          linkedin_url: 'https://linkedin.com/example.5',
          tech_stack: 'ruby, RoR, ',
          ta_recruiter: ta_user.id,
          email: 'example@example.com'
        }
      end

      it 'creates a new referral' do
        expect do
          post api_v1_referrals_url, params: data_referral
        end.to change {Referral.count}.by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid data' do
      let(:invalid_data_referral) { { full_name: Faker.name } }

      it 'does not create a referral' do
        expect do
          post api_v1_referrals_url, params: invalid_data_referral
        end.to_not change { Referral.count }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#assign_recruiter' do
    let(:valid_referral) do
      FactoryBot.create(:referral,
                        referred_by: regular_user.id,
                        tech_stack: 'ruby, RoR'
    )
    end
    context 'When call referral assign_recruiter endpoint with valid data' do
      it 'returns an 204 status' do
        patch "/api/v1/referrals/#{valid_referral.id}/ta/#{ta_user.id}"

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'When call referral assign_recruiter endpoint with invalid data' do
      context 'when the user is not a recruiter' do
        it 'returns a bad request request' do
          patch "/api/v1/referrals/#{valid_referral.id}/ta/#{regular_user.id}"

          expect(response).to have_http_status(:bad_request)
        end
      end
      context 'when the referral does not exist' do
        it 'returns a not found status' do
          patch "/api/v1/referrals/0/ta/#{ta_user.id}"

          expect(response).to have_http_status(:not_found)
        end
      end
      context 'when the recruiter does not exist' do
        it 'returns a not found status' do
          patch "/api/v1/referrals/#{valid_referral.id}/ta/0"

          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
