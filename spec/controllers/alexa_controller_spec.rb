require 'rails_helper'

RSpec.describe AlexaController, type: :controller do
  describe 'POST listener' do
    context 'happy path' do
      let(:valid_request) do
        JSON.parse(File.read(Rails.root.join('spec',
                                             'fixtures',
                                             'add_income',
                                             'without_date.json')))
      end

      before do
        post :listener, params: valid_request, format: :json
      end

      it 'respond with status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'sad path' do

    end
  end
end
