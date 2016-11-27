require 'spec_helper'

describe 'UsersController', type: :controller do
  describe 'listing users' do
    context 'without basic authentication' do
      before { get '/users' }
      let(:data) { JSON.parse(last_response.body) }

      it { expect(last_response.content_type).to eq 'application/json' }
      it { expect(last_response.status).to be(401) }
      it { expect(data).to eq({'error'=>'Basic Authentication not provided.'}) }
    end

    context 'with wrong credentials' do
      before {
        user = create(:user, name: 'bob')
        basic_authorize 'username', 'password'
        get '/users'
      }

      let(:data) { JSON.parse(last_response.body) }

      it { expect(last_response.content_type).to eq 'application/json' }
      it { expect(last_response.status).to be(401) }
      it { expect(data).to eq({'error'=>'User not authorized.'}) }
    end

    context 'with credentials' do
      before {
        user = create(:admin, name: 'jonh', password: "123")
        basic_authorize 'jonh', '123'
        get '/users'
      }

      let(:data) { JSON.parse(last_response.body) }

      it { expect(last_response.content_type).to eq 'application/json' }
      it { expect(last_response.status).to be(200) }
      it { expect(data).to_not include('error') }
    end
  end
end
