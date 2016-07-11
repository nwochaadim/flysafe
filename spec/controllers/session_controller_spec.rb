require 'rails_helper'

RSpec.describe SessionController, type: :controller do
  describe 'GET #new' do
    it 'assigns login style to view' do
      get :new
      expect(assigns(:login_style)).to eq('ui large form')
    end

    it 'renders new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'as an authenticated user' do
      it 'redirects to root path' do
        post :create, email: user.email, password: 'secret_key'
        expect(response).to redirect_to(root_path)
      end
    end

    context 'as an unauthenticated user' do
      it 'renders the new template' do
        post :create, email: '', password: ''
        expect(response).to render_template(:new)
      end

      it 'notifies the user of an invalid email or password' do
        post :create, email: '', password: ''
        expect(flash[:alert]).to eq('Invalid email or password')
      end
    end
  end

  describe 'GET #destroy' do
    it 'destroys users sessions' do
      get :destroy
      expect(session[:user_id]).to eq(nil)
    end

    it 'redirects user to login page' do
      get :destroy
      expect(response).to redirect_to(login_path)
    end
  end
end
