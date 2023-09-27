# frozen_string_literal: true

# spec/controllers/lottery_controller_spec.rb

require 'rails_helper'

RSpec.describe LotteryController, type: :controller do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #download_csv' do
    context 'when the file exists' do
      let(:file_path) { Rails.root.join('tmp', 'test.csv') }

      before do
        File.write(file_path, 'Sample content')
      end

      it 'sends the file for download' do
        get :download_csv, params: { filename: 'test.csv' }
        expect(response).to have_http_status(:ok)
        expect(response.headers['Content-Disposition']).to include('attachment')
      end
    end

    context 'when the file does not exist' do
      it 'redirects with an alert message' do
        get :download_csv, params: { filename: 'nonexistent.csv' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to be_present
      end
    end
  end
end
