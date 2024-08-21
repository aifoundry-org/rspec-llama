# frozen_string_literal: true

RSpec.configure do |config|
  WebMock.allow_net_connect!

  config.api_endpoint = 'http://localhost:3000'
  config.auth_endpoint = 'http://localhost:3000/users/sign_in'
  config.api_creds = { user: { email: '***email***', password: '***password***' } }

  config.include Rspec::Llama::Helpers
end

RSpec.describe 'Llama Rspec flow' do
  let(:model_version_name) { 'Version 1' }

  context 'when we want to fetch resources' do
    before do
      use_model('LLAMA_C', 'Vesion C')
      build_prompt('pt_c', 'Is Minsk the capital of Belarus?')
      build_assertion('1_ass', 'Yes')
      use_prompt('pt_c')
      use_assertion('1_ass')
    end

    it 'should fetch model & model_version' do
      expect(settled_model['name']).to eq('LLAMA_C')
      expect(settled_model_version['build_name']).to eq('Vesion C')
      expect(settled_prompt['name']).to eq('pt_c')
      expect(settled_assertion['name']).to eq('1_ass')
    end
  end

  context 'when we want to create resources(prompt, assertion)' do
    before do
      use_model('LLAMA_C', 'Vesion C')
      build_prompt('pt_s', 'Is Minsk the capital of Belarus?')
      build_assertion('ass_1', 'Yes')
    end

    it 'should create prompt & assertion' do
      expect(settled_prompt['name']).to eq('pt_s')
      expect(settled_assertion['name']).to eq('ass_1')
    end
  end

  context 'when we want to set resources' do
    before do
      use_model('LLAMA', model_version_name)
      build_prompt('pt_2', 'What is the capital of France?')
      build_assertion('ass_2', 'No')
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
      use_model('LLAMA_C', 'Vesion C')
      build_prompt('pt_c', 'What is the capital of France?')
      build_assertion('ass_c', 'Paris')
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

    let(:action) { execute_test_run }

    context 'model version 1' do
      let(:model_name) { 'LLAMA' }
      let(:model_version_name) { 'Version 2' }
      it 'should return a completed status' do
        action
        expect(test_run).to be_successful
      end
    end

    context 'model version 2' do
      let(:model_name) { 'LLAMA' }
      let(:model_version_name) { 'Version 2' }

      it 'should return a completed status' do
        action
        expect(test_run).to be_successful
      end

      context 'create a new prompt & assertion' do
        before do
          build_prompt('pt_2', 'what is the capital of france?')
          build_assertion('ass_2', 'paris')
        end

        it 'should return a completed status' do
          action
          expect(test_run).to be_failed
        end
      end

      context 'with more manual testing' do
        before do
          build_prompt('pt_2', 'what is the capital of france?')
          build_assertion('ass_2', 'paris')
        end

        it 'should return a completed status' do
          action
          expect(settled_test_results.last['status']).to eq('completed')
          expect(settled_assertion_results.first['state']).to eq('failed')
        end
      end
    end
  end
end
