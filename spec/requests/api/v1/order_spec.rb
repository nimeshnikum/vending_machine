require "rails_helper"

RSpec.describe "Buy endpoint", type: :request do
  let(:headers) { { "ACCEPT" => "application/json" } }
  let(:buyer) { create(:buyer, deposit: 75) }
  let(:seller) { create(:seller) }
  let(:product1) { create(:product, seller: seller) }
  let(:base_params) do
    {
      order: {
        product_id: product1.id,
        quantity: 2
      }
    }
  end

  describe '#buy' do
    subject { post '/api/v1/buy', params: base_params, headers: headers }

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
          expect(response_json.keys).to match_array([:id, :total_amount, :balance_amount, :product, :buyer])
          expect(response_json).to match({
                                           id: be_kind_of(Integer),
                                           total_amount: 30,
                                           balance_amount: [20, 20, 5],
                                           product: be_kind_of(Hash),
                                           buyer: be_kind_of(Hash)
                                         })
        end

        it 'creates a new order record' do
          subject
          expect(Order.count).to eq(1)
        end
      end

      context 'invalid request' do
        context 'insufficient quantity' do
          before do
            base_params[:order][:quantity] = 12
          end

          it 'raises an error if ordered more quantity than available' do
            subject
            expect(response.content_type).to eq("application/json; charset=utf-8")
            expect(response).to have_http_status(:bad_request)
          end

          it 'does not create an order' do
            subject
            expect(Order.count).to eq(0)
          end
        end

        context 'insufficient deposit' do
          before do
            base_params[:order][:quantity] = 6
          end

          it 'raises an error if buyer does not have enough deposit' do
            subject
            expect(response.content_type).to eq("application/json; charset=utf-8")
            expect(response).to have_http_status(:bad_request)
          end

          it 'does not create an order' do
            subject
            expect(Order.count).to eq(0)
          end
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
end
