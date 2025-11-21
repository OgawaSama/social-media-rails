require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  let(:user) { create(:user) }
  let(:business_user) { create(:user, :business_user) }
  let(:business) { business_user.business }

  describe 'GET #index' do
    before { sign_in user }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @bars with bars only' do
      bar = create(:business, business_type: 'bar')
      restaurant = create(:business, business_type: 'restaurant')
      get :index
      expect(assigns(:bars)).to include(bar)
      expect(assigns(:bars)).not_to include(restaurant)
    end
  end

  describe 'GET #show' do
    before { sign_in user }

    context 'when business exists' do
      it 'returns http success' do
        get :show, params: { id: business.id }
        expect(response).to have_http_status(:success)
      end

      it 'assigns the requested business to @business' do
        get :show, params: { id: business.id }
        expect(assigns(:business)).to eq(business)
      end

      it 'assigns business addresses' do
        address = create(:business_address, business: business)
        get :show, params: { id: business.id }
        expect(assigns(:addresses)).to include(address)
      end
    end

    context 'when business does not exist' do
      it 'redirects to root path' do
        get :show, params: { id: 999 }
        expect(response).to redirect_to(root_path)
      end

      it 'shows alert message' do
        get :show, params: { id: 999 }
        expect(flash[:alert]).to eq('Perfil empresarial não encontrado.')
      end
    end
  end

  describe 'GET #new' do
    before { sign_in user }

    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'builds a new business' do
      get :new
      expect(assigns(:business)).to be_a_new(Business)
    end

    it 'builds a new business address' do
      get :new
      expect(assigns(:business).business_addresses).not_to be_empty
    end
  end

  describe 'POST #create' do
    before { sign_in user }

    context 'with valid attributes' do
      let(:valid_attributes) do
        {
          business: {
            company_name: 'Novo Bar',
            cnpj: '12.345.678/0001-90',
            business_type: 'bar',
            business_addresses_attributes: {
              '0' => {
                street: 'Rua Nova, 123',
                city: 'Rio de Janeiro',
                state: 'RJ',
                zip: '20000-000'
              }
            }
          }
        }
      end

      it 'creates a new business' do
        expect {
          post :create, params: valid_attributes
        }.to change(Business, :count).by(1)
      end

      it 'redirects to the business page' do
        post :create, params: valid_attributes
        expect(response).to redirect_to(business_path(Business.last))
      end

      it 'updates user type to BusinessUser' do
        post :create, params: valid_attributes
        expect(user.reload.type).to eq('BusinessUser')
      end

      it 'shows success notice' do
        post :create, params: valid_attributes
        expect(flash[:notice]).to eq('Perfil empresarial criado com sucesso!')
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) do
        {
          business: {
            company_name: '',
            cnpj: '',
            business_type: 'bar'
          }
        }
      end

      it 'does not create a new business' do
        expect {
          post :create, params: invalid_attributes
        }.not_to change(Business, :count)
      end

      it 're-renders the new template' do
        post :create, params: invalid_attributes
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    before { sign_in business_user }

    it 'returns http success' do
      get :edit, params: { id: business.id }
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested business to @business' do
      get :edit, params: { id: business.id }
      expect(assigns(:business)).to eq(business)
    end
  end
end
