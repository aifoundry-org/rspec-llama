# frozen_string_literal: true

require 'bundler/setup'
require 'dotenv/load'
require 'rspec/llama'

RSpec.describe 'Popular Ruby Frameworks' do
  subject(:run_model!) { model_runner.call(model_configuration, prompt) }

  let(:prompt) { 'What are the most popular Ruby frameworks?' }

  context 'with OpenAI model runner' do
    let(:model_runner) { build_model_runner(:openai, access_token: ENV.fetch('OPENAI_ACCESS_TOKEN')) }
    let(:model_configuration) { build_model_configuration(:openai, model:, temperature:, seed:) }
    let(:temperature) { 0.5 }
    let(:seed) { RSpec.configuration.seed }

    context 'with gpt-4o-mini model' do
      let(:model) { 'gpt-4o-mini' }

      it 'matches only Ruby frameworks', :aggregate_failures do
        result = run_model!

        expect(result).to match('Ruby on Rails')
        expect(result).to match_any('RoR', 'Ruby on Rails')
        expect(result).to match_all('Ruby on Rails', 'Sinatra', 'Hanami')
        expect(result).to match_none('Django', 'Flask', 'Symfony', 'Laravel', 'Yii')
      end
    end

    context 'with gpt-4o model' do
      let(:model) { 'gpt-4o' }

      # also supports short syntax
      it { is_expected.to match_any('RoR', 'Ruby on Rails') }
      it { is_expected.not_to match_any('Django', 'Flask', 'Symfony', 'Laravel', 'Yii') }
    end

    context 'with gpt-4-turbo model' do
      let(:model) { 'gpt-4-turbo' }

      it 'matches only Ruby frameworks using regular expressions', :aggregate_failures do
        result = run_model!

        expect(result).to match(/Ruby on Rails/)
        expect(result).to match_any(/Rails/, /Sinatra/)
        expect(result).to match_all(/Ruby on Rails/, /Sinatra/, /Hanami/)
        expect(result).to match_none(/Django/, /Flask/, /Symfony/)
      end

      context 'with different temperature' do
        let(:temperature) { 0.1 }

        it { is_expected.to match_none('Django', 'Flask', 'Symfony', 'Laravel', 'Yii') }
      end

      context 'with prompt for Python frameworks' do
        let(:prompt) { 'What are the most popular Python frameworks?' }

        it 'does not include Ruby and PHP frameworks', :aggregate_failures do
          result = run_model!

          expect(result).to match_all('Django', 'Flask')
          expect(result).to match_none('Ruby on Rails', 'Sinatra', 'Hanami')
          expect(result).to match_none('Symfony', 'Laravel', 'Yii')
        end
      end
    end
  end
end
