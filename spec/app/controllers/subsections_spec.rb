require 'spec_helper'

describe 'SubsectionsController', type: :controller do
  before { create(:subsection) }

  describe 'authentication' do
    context 'without basic authentication' do
      describe 'get subsections' do
        before { get '/section/1/subsections' }
        let(:data) { JSON.parse(last_response.body) }

        it { expect(last_response.content_type).to eq 'application/json' }
        it { expect(last_response.status).to be(200) }
        it { expect(data).to_not include('errors') }
      end

      describe 'create subsections' do
        before {
          post '/section/1/subsections', { title: 'baz', description: 'foo'}
        }

        let(:data) { JSON.parse(last_response.body) }

        it { expect(last_response.content_type).to eq 'application/json' }
        it { expect(last_response.status).to be(401) }
        it { expect(data).to eq({'errors'=>'Basic Authentication not provided.'}) }
      end

      describe 'delete subsections' do
        before do
          create(:subsection)
          delete '/section/1/subsections/1'
        end

        let(:data) { JSON.parse(last_response.body) }

        it { expect(last_response.content_type).to eq 'application/json' }
        it { expect(last_response.status).to be(401) }
        it { expect(data).to eq({'errors'=>'Basic Authentication not provided.'}) }
      end

      context 'with wrong credentials' do
        before do
          user = create(:admin, name: 'jonh', password: '123')
          basic_authorize 'jonh', '123qweqweq'
        end

        describe 'get subsections' do
          before { get '/section/1/subsections' }
          let(:data) { JSON.parse(last_response.body) }

          it { expect(last_response.content_type).to eq 'application/json' }
          it { expect(last_response.status).to be(200) }
          it { expect(data).to_not include('errors') }
        end

        describe 'create sections' do
          before { post '/sections', { title: 'roy', description: 'foo'} }
          let(:data) { JSON.parse(last_response.body) }

          it { expect(last_response.content_type).to eq 'application/json' }
          it { expect(last_response.status).to be(401) }
          it { expect(data).to eq({'errors'=>'User not authorized.'}) }
        end

        describe 'delete sections' do
          before do
            section = create(:section, title: 'foosection')
            delete "/sections/#{section.id}"
          end

          let(:data) { JSON.parse(last_response.body) }

          it { expect(last_response.content_type).to eq 'application/json' }
          it { expect(last_response.status).to be(401) }
          it { expect(data).to eq({'errors'=>'User not authorized.'}) }
          it "does not delete section" do
            get '/sections'
            expect(last_response.body).to include('foosection')
          end
        end
      end
    end
  end

  describe 'listing sections' do
    before do
      create(:admin, name: 'jonh', password: '123')
      basic_authorize 'jonh', '123'
      create(:subsection)
      get '/section/1/subsections'
    end

    let(:data) { JSON.parse(last_response.body) }

    it { expect(last_response.content_type).to eq 'application/json' }
    it { expect(last_response.status).to be(200) }
    it { expect(data.size).to eq(1) }
  end

  describe 'adding sections' do
    before do
      create(:admin, name: 'jonh', password: '123')
      basic_authorize 'jonh', '123'
    end

    context 'passing required params' do
      before do
        post '/section/1/subsections',
          { title: 'foosection', description: 'some foo'}
      end

      let(:data) { JSON.parse(last_response.body) }

      it { expect(last_response.content_type).to eq 'application/json' }
      it { expect(last_response.status).to be(200) }
      it { expect(data).to_not include('errors') }

      it 'contains section created' do
        get '/section/1/subsections'
        expect(last_response.body).to include('foosection')
      end
    end

    context 'without required params' do
      let(:data) { JSON.parse(last_response.body) }

      it 'validates title' do
        post '/section/1/subsections', { description: '123123' }
        expect(last_response.status).to eq 400
        expect(data).to include('errors')
      end

      it 'accepts empty description' do
        post '/section/1/subsections', { title: 'foo' }
        expect(last_response.status).to eq 200
        expect(data).to_not include('errors')
      end
    end
  end

  describe 'deleting sections' do
    before do
      create(:admin, name: 'jonh', password: '123')
      basic_authorize 'jonh', '123'

      @section = create(:section)
      create(:subsection, title: 'baz', section: @section)
      subsection = create(:subsection, title: 'foo', section: @section)
      delete "/section/#{@section.id}/subsections/#{subsection.id}"
    end

    let(:data) { JSON.parse(last_response.body) }

    it { expect(last_response.content_type).to eq 'application/json' }
    it { expect(last_response.status).to be(200) }
    it { expect(data).to_not include('errors') }

    it 'not contains section deleted' do
      get "/section/#{@section.id}/subsections"
      expect(last_response.body).to include('baz')
      expect(last_response.body).to_not include('foo')
    end
  end
end
