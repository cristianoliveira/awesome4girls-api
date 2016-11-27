require 'spec_helper'

describe 'ProjectsController', type: :controller do
  describe 'authentication' do
    context 'without basic authentication' do
      describe 'get projects' do
        before { get '/projects' }
        let(:data) { JSON.parse(last_response.body) }

        it { expect(last_response.content_type).to eq 'application/json' }
        it { expect(last_response.status).to be(200) }
        it { expect(data).to_not include('errors') }
      end

      describe 'create projects' do
        before { post '/projects', { title: 'baz', description: 'foo'} }
        let(:data) { JSON.parse(last_response.body) }

        it { expect(last_response.content_type).to eq 'application/json' }
        it { expect(last_response.status).to be(401) }
        it { expect(data).to eq({'errors'=>'Basic Authentication not provided.'}) }
      end

      describe 'delete projects' do
        before do
          create(:project)
          delete '/projects/1'
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

        describe 'get projects' do
          before { get '/projects' }
          let(:data) { JSON.parse(last_response.body) }

          it { expect(last_response.content_type).to eq 'application/json' }
          it { expect(last_response.status).to be(200) }
          it { expect(data).to_not include('errors') }
        end

        describe 'create projects' do
          before { post '/projects', { title: 'roy', description: 'foo'} }
          let(:data) { JSON.parse(last_response.body) }

          it { expect(last_response.content_type).to eq 'application/json' }
          it { expect(last_response.status).to be(401) }
          it { expect(data).to eq({'errors'=>'User not authorized.'}) }
        end

        describe 'delete projects' do
          before do
            project = create(:project, title: 'fooproject')
            delete "/projects/#{project.id}"
          end

          let(:data) { JSON.parse(last_response.body) }

          it { expect(last_response.content_type).to eq 'application/json' }
          it { expect(last_response.status).to be(401) }
          it { expect(data).to eq({'errors'=>'User not authorized.'}) }
          it "does not delete project" do
            get '/projects'
            expect(last_response.body).to include('fooproject')
          end
        end
      end
    end
  end

  describe 'listing projects' do
    before do
      create(:admin, name: 'jonh', password: '123')
      basic_authorize 'jonh', '123'
      create(:project)
      get '/projects'
    end

    let(:data) { JSON.parse(last_response.body) }

    it { expect(last_response.content_type).to eq 'application/json' }
    it { expect(last_response.status).to be(200) }
    it { expect(data.size).to eq(1) }
  end

  describe 'adding projects' do
    before do
      create(:admin, name: 'jonh', password: '123')
      basic_authorize 'jonh', '123'
      @subsection = create(:subsection)
    end

    context 'passing required params' do
      before do
        post '/projects',
          { title: 'fooproject',
            description: 'some foo',
            subsection: @subsection.id }
      end

      let(:data) { JSON.parse(last_response.body) }

      it { expect(last_response.content_type).to eq 'application/json' }
      it { expect(last_response.status).to be(200) }
      it { expect(data).to_not include('errors') }

      it 'contains project created' do
        get '/projects'
        expect(last_response.body).to include('fooproject')
      end
    end

    context 'without required params' do
      let(:data) { JSON.parse(last_response.body) }

      it 'validates title' do
        post '/projects', { description: '123123' }
        expect(last_response.status).to eq 400
        expect(data).to include('errors')
      end

      it 'validates description' do
        post '/projects', { title: 'foo', subsection: @subsection.id }
        expect(last_response.status).to eq 400
        expect(data).to include('errors')
      end

      it 'accepts empty languages' do
        post '/projects', {
          title: 'foo',
          description: 'foodescription',
          subsection: @subsection.id
        }
        expect(last_response.status).to eq 200
        expect(data).to_not include('errors')
      end
    end
  end

  describe 'deleting projects' do
    before do
      create(:admin, name: 'jonh', password: '123')
      basic_authorize 'jonh', '123'
      create(:project, title: 'bazproject')
      project = create(:project, title: 'fooproject')
      delete "/projects/#{project.id}"
    end

    let(:data) { JSON.parse(last_response.body) }

    it { expect(last_response.content_type).to eq 'application/json' }
    it { expect(last_response.status).to be(200) }
    it { expect(data).to_not include('errors') }

    it 'not contains project deleted' do
      get '/projects'
      expect(last_response.body).to include('bazproject')
      expect(last_response.body).to_not include('fooproject')
    end
  end
end
