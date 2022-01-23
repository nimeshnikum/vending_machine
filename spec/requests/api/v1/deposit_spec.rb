require "rails_helper"

RSpec.describe "Deposit endpoints", type: :request do
  let(:headers) { { "ACCEPT" => "application/json" } }
  let(:buyer) { create(:buyer, deposit: 10) }
  let(:seller) { create(:seller) }
  let(:base_params) do
    {
      user: {
        deposit: 5
      }
    }
  end

  describe '#deposit' do
    subject { post '/api/v1/deposit', params: base_params, headers: headers }

    context 'with buyer role' do
      before(:each) do
        auth_headers = buyer.create_new_auth_token
        headers.merge!(auth_headers)
      end

      context 'valid request' do
        it "returns http success status" do
          subject
          expect(response.content_type).to eq("application/json; charset=utf-8")
          expect(response).to have_http_status(:success)
        end

        it 'returns json output' do
          subject
          expect(response_json.keys).to match_array([:id, :email, :name, :deposit, :roles])
          expect(response_json).to match({
                                           id: buyer.id,
                                           email: buyer.email,
                                           name: buyer.name,
                                           deposit: 15,
                                           roles: be_kind_of(Array)
                                         })
        end
      end

      context 'invalid request' do
        before do
          base_params[:user][:deposit] = 12
        end

        it "returns http error status" do
          subject
          expect(response.content_type).to eq("application/json; charset=utf-8")
          expect(response).to have_http_status(:bad_request)
        end

        it 'does not update deposit' do
          subject
          expect(buyer.deposit).to eq(10)
        end
      end
    end

    context 'with seller role' do
      before(:each) do
        auth_headers = seller.create_new_auth_token
        headers.merge!(auth_headers)
      end

      it "returns http error status" do
        subject
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#reset' do
    subject { delete '/api/v1/reset', params: {}, headers: headers }

    context 'with buyer role' do
      before(:each) do
        auth_headers = buyer.create_new_auth_token
        headers.merge!(auth_headers)
      end

      it "returns http success status" do
        subject
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:success)
      end

      it 'returns json output' do
        subject
        expect(response_json.keys).to match_array([:id, :email, :name, :deposit, :roles])
        expect(response_json).to match({
                                         id: buyer.id,
                                         email: buyer.email,
                                         name: buyer.name,
                                         deposit: 0,
                                         roles: be_kind_of(Array)
                                       })
      end
    end

    context 'with seller role' do
      before(:each) do
        auth_headers = seller.create_new_auth_token
        headers.merge!(auth_headers)
      end

      it "returns http error status" do
        subject
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
