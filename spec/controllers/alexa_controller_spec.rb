require 'rails_helper'

RSpec.describe AlexaController, type: :controller do
  describe 'POST listener' do
    let(:valid_intent_request) do
      JSON.parse(File.read(Rails.root.join('spec',
                                           'fixtures',
                                           'alexa_requests',
                                           'add_income',
                                           'without_date.json')), symbolize_names: true)
    end
    let(:valid_launch_request) do
      JSON.parse(File.read(Rails.root.join('spec',
                                           'fixtures',
                                           'alexa_requests',
                                           'launch_request.json')), symbolize_names: true)
    end
    let(:valid_end_session_request) do
      JSON.parse(File.read(Rails.root.join('spec',
                                           'fixtures',
                                           'alexa_requests',
                                           'end_session_request.json')), symbolize_names: true)
    end

    context 'happy path' do
      context 'in live mode' do
        shared_examples 'valid_response' do
          it 'respond with status ok' do
            expect(response).to have_http_status(:ok)
          end

          it 'respond in json' do
            expect(response.content_type).to eq 'application/json'
          end

          it 'assign current_user' do
            expect(assigns[:current_user]).to be_a(User)
          end
        end

        context 'with IntentRequest' do
          before do
            post :listener, params: valid_intent_request, format: :json
          end

          include_examples 'valid_response'
        end

        context 'with LaunchRequest' do
          before do
            post :listener, params: valid_launch_request, format: :json
          end

          include_examples 'valid_response'
        end

        context 'with SessionEndedRequest' do
          before do
            post :listener, params: valid_end_session_request, format: :json
          end

          include_examples 'valid_response'
        end
      end

      context 'choose right method for type' do
        controller do
          def listener
            head :ok
          end

          private

          def render_launch_request
            head :created
          end

          def render_end_session
            head :accepted
          end
        end

        before do
          routes.draw { post 'listener' => 'alexa#listener' }
        end

        it 'respond from listener on IntentRequest' do
          post :listener, params: valid_intent_request, format: :json
          expect(response).to have_http_status(:ok)
        end

        it 'respond from render_launch_request on LaunchRequest' do
          valid_intent_request[:request][:type] = 'LaunchRequest'
          post :listener, params: valid_intent_request, format: :json
          expect(response).to have_http_status(:created)
        end

        it 'respond from render_end_session on SessionEndedRequest' do
          valid_intent_request[:request][:type] = 'SessionEndedRequest'
          post :listener, params: valid_intent_request, format: :json
          expect(response).to have_http_status(:accepted)
        end
      end
    end

    context 'sad path' do
      shared_examples 'bad_request' do
        it 'respond with status bad_request' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when type invalid' do
        before do
          valid_intent_request[:request][:type] = 'invalid'
          post :listener, params: valid_intent_request, format: :json
        end

        include_examples 'bad_request'
      end

      context 'when request without user key' do
        before do
          valid_intent_request[:session].delete(:user)
          post :listener, params: valid_intent_request, format: :json
        end

        include_examples 'bad_request'
      end
    end
  end
end
