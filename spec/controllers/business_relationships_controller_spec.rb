require 'rails_helper'

RSpec.describe BusinessRelationshipsController, type: :controller do
  let(:user) { create(:user) }
  let(:business) { create(:business) }

  before { sign_in user }

  describe 'POST #create' do
    it 'creates a new business relationship' do
      expect {
        post :create, params: { id: business.id }
      }.to change(BusinessRelationship, :count).by(1)
    end

    it 'calls follow_business on current user' do
      post :create, params: { id: business.id }
      expect(user.following_business?(business)).to be true
    end

    it 'redirects back with notice' do
      post :create, params: { id: business.id }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to include('Agora você está seguindo')
    end

    context 'when business not found' do
      it 'redirects back with alert' do
        post :create, params: { id: 999 }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('Bar/empresa não encontrado.')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      user.follow_business(business)
    end

    it 'destroys the business relationship' do
      expect {
        delete :destroy, params: { id: business.id }
      }.to change(BusinessRelationship, :count).by(-1)
    end

    it 'calls unfollow_business on current user' do
      delete :destroy, params: { id: business.id }
      expect(user.following_business?(business)).to be false
    end

    it 'redirects back with notice' do
      delete :destroy, params: { id: business.id }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to include('Você deixou de seguir')
    end
  end
end
