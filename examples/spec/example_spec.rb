# frozen_string_literal: true

require 'bundler/setup'
require 'dotenv/load'
require 'rspec/llama'

RSpec.shared_examples 'application frameworks' do
  describe 'popular Ruby frameworks' do
    let(:prompt) { 'What are the most popular Ruby frameworks?' }

    it 'matches Ruby frameworks', :aggregate_failures do
      result = run_model!

      expect(result).to match_all('Ruby on Rails', 'Sinatra', 'Hanami')
      expect(result).to match_none('Django', 'Flask', 'Symfony', 'Laravel', 'Yii')
    end
  end

  describe 'dependencies for the Rails gem' do
    let(:prompt) { 'What gems does the Rails gem depend on?' }

    it 'matches Rails dependencies' do
      result = run_model!

      expect(result).to match_all(
        'activesupport', 'activerecord', 'actionpack', 'actionview',
        'actionmailer', 'actioncable', 'railties'
      )
    end
  end

  describe 'popular Python frameworks' do
    let(:prompt) { 'What are the most popular Python frameworks?' }

    it 'matches Python frameworks', :aggregate_failures do
      result = run_model!

      expect(result).to match_all('Django', 'Flask')
      expect(result).to match_none('Ruby on Rails', 'Sinatra', 'Hanami', 'Symfony', 'Laravel', 'Yii')
    end
  end
end

RSpec.describe 'Popular Application Frameworks' do
  subject(:run_model!) { runner.call(config, prompt) }

  shared_examples 'model assertion comparison' do |model, temperature = 0.5|
    let(:model_runner) { build_model_runner(:openai, access_token: ENV.fetch('OPENAI_ACCESS_TOKEN')) }
    let(:model_configuration) { build_model_configuration(:openai, model:, temperature:) }

    it "validates assertion for model #{model} with temperature #{temperature}" do
      expect(assertion_result).to be_passed
    end
  end

  context 'when comparison across models' do
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

    context 'when distance to the Moon' do
      let(:prompt) { build_model_prompt('What is the distance to the Moon in kilometers?') }
      let(:assertion) { build_model_assertion(:include_any, '384,400') }

      models.each do |model_name, temperature|
        include_examples 'model assertion comparison', model_name, temperature
      end
    end
  end

  context 'with OpenAI model runner' do
    let(:runner) { build_model_runner(:openai, access_token: ENV.fetch('OPENAI_ACCESS_TOKEN')) }
    let(:config) { build_model_configuration(:openai, model:, temperature:, seed: RSpec.configuration.seed) }
    let(:temperature) { 0.5 }

    context 'with gpt-4o-mini model' do
      let(:model) { 'gpt-4o-mini' }

      include_examples 'application frameworks'
    end

    context 'with gpt-4o model' do
      let(:model) { 'gpt-4o' }

      include_examples 'application frameworks'
    end

    context 'with gpt-4-turbo model' do
      let(:model) { 'gpt-4-turbo' }

      include_examples 'application frameworks'

      context 'with different temperature' do
        let(:temperature) { 0.1 }

        include_examples 'application frameworks'
      end
    end
  end
end
