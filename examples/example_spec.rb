# frozen_string_literal: true

RSpec.configure do |config|
  WebMock.allow_net_connect!

  config.api_endpoint = 'http://localhost:3000'
  config.auth_endpoint = 'http://localhost:3000/users/sign_in'
  config.api_creds = { user: { email: '***email***', password: '***password***' } }

  config.include Rspec::Llama::Helpers
end

RSpec.describe 'Llama Rspec flow' do
  let(:test_run_name) { 'fake_test_run_name' }
  let(:model_version_name) { 'Version 1' }

  context 'when we want to set resources' do
    before do
      use_model('LLAMA', model_version_name)
      use_prompt('pt_2')
      use_assertion('ass_2')
    end

    it 'should set model, prompt, assertion' do
      expect(settled_model['name']).to eq('LLAMA')
      expect(settled_model_version['build_name']).to eq(model_version_name)
      expect(settled_prompt['name']).to eq('pt_2')
      expect(settled_assertion['name']).to eq('ass_2')
    end
  end

  context 'when we want to create resources' do
    before do
      create_model('LLAMA_C', 'Vesion C')
      create_prompt('pt_c', 'What is the capital of France?')
      create_assertion('ass_c', 'Paris')
    end

    it 'should create model, model_version, prompt, assertion' do
      expect(settled_model['name']).to eq('LLAMA_C')
      expect(settled_model_version['build_name']).to eq('Vesion C')
      expect(settled_prompt['name']).to eq('pt_c')
      expect(settled_assertion['name']).to eq('ass_c')
    end
  end

  describe '#execute_test_run' do
    before do
      use_model(model_name, model_version_name)
      use_prompt('pt_2')
      use_assertion('ass_2')
    end

    let(:action) { execute_test_run(test_run_name, settled_prompt['id'], settled_assertion['id'], settled_model_version['id']) }

    context 'model version 1' do
      let(:model_name) { 'LLAMA' }
      let(:model_version_name) { 'Version 1' }
      it 'should return a completed status' do
        action
        expect(settled_test_results.last['status']).to eq('completed')
        expect(settled_assertion_results.first['state']).to eq('passed')
      end
    end

    context 'model version 2' do
      let(:model_name) { 'LLAMA' }
      let(:model_version_name) { 'Version 2' }

      it 'should return a completed status' do
        action
        expect(settled_test_results.last['status']).to eq('completed')
        expect(settled_assertion_results.first['state']).to eq('passed')
      end

      context 'create a new prompt & assertion' do
        before do
          create_prompt('pt_2', 'What is the capital of France?')
          create_assertion('ass_2', 'Paris')
        end

        it 'should return a completed status' do
          action
          expect(settled_test_results.last['status']).to eq('completed')
          expect(settled_assertion_results.first['state']).to eq('passed')
        end
      end
    end
  end
end

