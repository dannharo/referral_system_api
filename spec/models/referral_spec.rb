describe Referral, type: :model do
  let(:regular_user) { create(:user, role_id: user_role.id) }
  let(:user_role) { create(:role, :role_user) }
  context 'validations' do
    subject { create :referral , referrer: regular_user }
    it 'creates a referral when valid attributes' do
      expect(subject).to be_valid
    end

    context 'when no referrer assigned' do
      subject { create :referral }
      it 'doesn\'t create a referral' do
        expect { subject }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'uniqueness validations' do
      subject { create :referral, referrer: regular_user }
      let(:email) { 'testing@email.com' }
      let(:linkedin_url) { 'https://linkedin.com/examplenoduplicated' }
      let(:phone_number) { '5512345678' }
      before do
        create :referral,
               referrer: regular_user,
               email: email,
               linkedin_url: linkedin_url,
               phone_number: phone_number
      end

      it 'doesn\'t create a referral when email is duplicated' do
        subject.email = email
        expect{ subject.save! }.to raise_error ActiveRecord::RecordInvalid, 'Validation failed: Email The email is already taken'
      end

      it 'doesn\'t create a referral when linkedin_url is duplicated' do
        subject.linkedin_url = linkedin_url
        expect{ subject.save! }.to raise_error ActiveRecord::RecordInvalid, 'Validation failed: Linkedin url The linkedin profile is already taken'
      end

      it 'doesn\'t create a referral when phone_number is duplicated' do
        subject.phone_number = phone_number
        expect{ subject.save! }.to raise_error ActiveRecord::RecordInvalid, 'Validation failed: Phone number The phone number is already taken'
      end
    end
  end
end
