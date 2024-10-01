# frozen_string_literal: true

require 'bundler/setup'
require 'dotenv/load'
require 'rspec/llama'

RSpec.describe RSpec::Llama do
  subject(:assertion_result) { assertion.call(runner_result) }

  let(:prompt) { build_model_prompt('Is Minsk the capital of Belarus?') }
  let(:assertion) { build_model_assertion(:include_any, 'Yes') }
  let(:runner_result) { model_runner.call(model_configuration, prompt) }

  shared_examples 'model assertion comparison' do |model, temperature = 0.5|
    let(:model_runner) { build_model_runner(:openai, access_token: ENV.fetch('OPENAI_ACCESS_TOKEN')) }
    let(:model_configuration) { build_model_configuration(:openai, model: model, temperature: temperature) }

    it "validates assertion for model #{model} with temperature #{temperature}" do
      expect(assertion_result).to be_passed
    end
  end

  context 'comparison across models' do
    models = { 'gpt-4o-mini' => 0.1, 'gpt-4o' => 0.5, 'gpt-4-turbo' => 0.1 }

    models.each do |model_name|
      include_examples 'model assertion comparison', model_name
    end

    context 'when adjusting prompt and assertion' do
      let(:prompt) { build_model_prompt('What is the capital of Belarus?') }
      let(:assertion) { build_model_assertion(:include_any, 'Minsk') }

      models.each do |model_name, temperature|
        include_examples 'model assertion comparison', model_name, temperature
      end
    end

    context 'distance to the Moon' do
      let(:prompt) { build_model_prompt('What is the distance to the Moon in kilometers?') }
      let(:assertion) { build_model_assertion(:include_any, '384,400') }

      models.each do |model_name, temperature|
        include_examples 'model assertion comparison', model_name, temperature
      end
    end
  end

  context 'with OpenAI model runner' do
    let(:model_runner) { build_model_runner(:openai, access_token: ENV.fetch('OPENAI_ACCESS_TOKEN')) }
    let(:model_configuration) { build_model_configuration(:openai, model:, temperature:) }
    let(:temperature) { 0.5 }

    context 'with gpt-4o-mini model' do
      let(:model) { 'gpt-4o-mini' }

      it 'supports basic syntax' do
        expect(assertion_result).to be_passed
      end

      # also supports short syntax
      it { is_expected.to be_passed }
      it { is_expected.not_to be_failed }
    end

    context 'with gpt-4o model' do
      let(:model) { 'gpt-4o' }

      it { is_expected.to be_passed }
    end

    context 'with gpt-4-turbo model' do
      let(:model) { 'gpt-4-turbo' }

      it { is_expected.to be_passed }

      context 'with different temperature' do
        let(:temperature) { 0.1 }

        it { is_expected.to be_passed }
      end

      context 'with different assertion' do
        let(:assertion) { build_model_assertion(:exclude_all, 'No') }

        it { is_expected.to be_passed }
      end
    end
  end
end
