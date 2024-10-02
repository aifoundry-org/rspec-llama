# RSpec::Llama

[![Gem Version](https://badge.fury.io/rb/rspec-llama.svg)](https://badge.fury.io/rb/rspec-llama)
[![Build Status](https://github.com/aifoundry-org/rspec-llama/actions/workflows/rspec-llama.yml/badge.svg)](https://github.com/aifoundry-org/rspec-llama/actions)

## Introduction

**RSpec::Llama** is a versatile testing framework designed to integrate AI model testing seamlessly into the RSpec ecosystem. Whether you're working with OpenAI's GPT models, Llama, or other AI models, RSpec::Llama simplifies the process of configuring, running, and validating your models' outputs.

## Features

- **Model Configurations**: Easily set up and customize configurations for various AI models like OpenAI, Llama, and Ollama. Configure models with parameters such as temperature, token limits, and stop sequences.
- **Model Runners**: Seamlessly run AI models using predefined configurations, allowing you to execute prompts and capture their outputs in a simple and consistent way.
- **Comprehensive Assertions**: Validate model outputs against expected results using advanced matchers, such as `match`, `match_all`, `match_any`, and `match_none`, to ensure your models behave as expected in different scenarios.
- **RSpec Integration**: Fully integrated with RSpec, enabling AI model testing to fit naturally into your existing test suite.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-llama'
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install rspec-llama
```

## RSpec Helpers

RSpec::Llama provides a set of helpers to simplify the configuration and interaction with AI models during testing.
These helpers allow you to easily define model configurations, runners, and prompts, making it easier to integrate AI
models like OpenAI, Llama, and Ollama into your RSpec tests.

### `build_model_configuration(configuration_type, **options)`

The `build_model_configuration` helper is used to create a model configuration object for various AI models,
allowing you to specify and customize the parameters that will be used during the model's execution.
This helper supports different types of model configurations, such as OpenAI's GPT models and Llama models.

Parameters:

`configuration_type`: Symbol representing the type of model configuration. Possible values are `:openai`, `:llama_cpp`, and `:ollama`.

`options`: Hash of configuration options specific to the selected model type.

#### OpenAI Model Configuration

Supported Options:

`model`: The model to use (e.g., 'gpt-3.5-turbo', 'gpt-4').

`temperature`: Sampling temperature between 0 and 2. Higher values make output more random.

`stop`: Up to 4 sequences where the API will stop generating further tokens.

`seed`: A seed for controlling the randomness in generation. This ensures consistent outputs between runs when the same seed and model configuration are used. Useful for debugging and testing.

```ruby
config = build_model_configuration(:openai, model: 'gpt-4', temperature: 0.7)

# Example usage
runner = build_model_runner(:openai, access_token: ENV['OPENAI_ACCESS_TOKEN'])
prompt = 'What gems does the Rails gem depend on?'
result = runner.call(config, prompt)

expect(result).to match_all(
  'activesupport', 'activerecord', 'actionpack', 'actionview',
  'actionmailer', 'actioncable', 'railties'
)
```

#### LlamaCpp Model Configuration

The LlamaCpp model configuration is used to set parameters for models running with the llama.cpp implementation.

```ruby
config = build_model_configuration(:llama_cpp, model: '/path/to/model', temperature: 0.5, predict: 500)

# Example usage
runner = build_model_runner(:llama_cpp, cli_path: '/path/to/llama-cli')
prompt = 'What are the most popular Ruby frameworks?'
result = runner.call(config, prompt)

expect(result).to match_all('Ruby on Rails', 'Sinatra', 'Hanami')
```

Supported Options:

`model`: The path to the model file.

`temperature`: Sampling temperature between 0 and 2.

`predict`: The number of tokens to predict.

`stop`: Regular expression to define where the model should stop generating text.

#### Ollama Model Configuration

The Ollama model configuration is similar to the OpenAI and LlamaCpp configurations but tailored to the Ollama models.

```ruby
config = build_model_configuration(:ollama, model: 'ollama3.1')

# Example usage
runner = build_model_runner(:ollama)
prompt = 'Who created the Ruby programming language?'
result = runner.call(config, prompt)

expect(result).to match_all('Yukihiro', 'Matz', 'Matsumoto')
```

Supported Options:

`model`: The model to use (e.g., 'ollama3.1').

### `build_model_runner(runner_type, **options)`

The `build_model_runner` helper is used to create a model runner object that interacts with various AI models,
allowing you to execute prompts and retrieve results. This helper supports different types of model runners,
such as those for OpenAI's GPT models, Llama models, and others.

Parameters:

`runner_type`: Symbol representing the type of model runner. Possible values are `:openai`, `:llama_cpp`, and `:ollama`.

`options`: Hash of options specific to the selected runner type, such as API credentials or executable paths.

#### OpenAI Model Runner

The OpenAI model runner interacts with OpenAI's API to execute prompts and retrieve responses from models like GPT-3.5 or GPT-4.

```ruby
runner = build_model_runner(:openai, access_token: ENV['OPENAI_ACCESS_TOKEN'], organization_id: ENV['OPENAI_ORGANIZATION_ID'])

# Example usage
config = build_model_configuration(:openai, model: 'gpt-4', temperature: 0.7)
prompt = 'What is the capital of France?'
result = runner.call(config, prompt)
puts result.to_s
```

Supported Options:

`access_token`: The API key for accessing OpenAI's API.

`organization_id`: (Optional) The ID of your OpenAI organization.

`project_id`: (Optional) The ID of your OpenAI project.

#### LlamaCpp Model Runner

coming soon

#### Ollama Model Runner

coming soon

## RSpec Matchers

This gem provides RSpec matchers for comparing model outputs, focusing on language models like those
from OpenAI and Llama. These matchers help assert the presence or absence of specific strings or patterns
in the output, and they are designed to work seamlessly with RSpec's syntax.

### `match(expected)`

The `match` matcher is used to check if a string or pattern is present in the actual output.

```ruby
expect(result).to match('Ruby on Rails')
expect(result).to match(/Rails/)
```

**Passes if**: The output contains the exact string or matches the given regular expression.

**Fails if**: The string or pattern is not present in the output.

### `match_all(*expected)`

The `match_all` matcher checks if all the provided strings or patterns are present in the actual output.

```ruby
expect(result).to match_all('Ruby on Rails', 'Sinatra', 'Hanami')
expect(result).to match_all(/Rails/, /Sinatra/)
```

**Passes if**: All strings or patterns are found in the output.

**Fails if**: Any one of the strings or patterns is missing from the output.

### `match_any(*expected)`

The `match_any` matcher checks if any of the provided strings or patterns are present in the actual output.

```ruby
expect(result).to match_any('RoR', 'Ruby on Rails')
expect(result).to match_any(/Rails/, /Sinatra/)
```

**Passes if**: At least one string or pattern is found in the output.

**Fails if**: None of the strings or patterns are found in the output.

### `match_none(*expected)`

The `match_none` matcher ensures that none of the provided strings or patterns are present in the actual output.

```ruby
expect(result).to match_none('Django', 'Flask', 'Symfony')
expect(result).to match_none(/Django/, /Flask/)
```

**Passes if**: None of the strings or patterns are found in the output.

**Fails if**: Any one of the strings or patterns is found in the output.

## Full Example

Here’s a full example that demonstrates how to use helpers and matchers to test various models with different configurations.

```ruby
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
```

## Development

To contribute to the development of this gem, follow the steps below:

### Setting Up the Development Environment

1. Clone the repository:

   ```bash
   git clone https://github.com/aifoundry-org/rspec-llama.git
   cd rspec-llama
   ```

2. Install dependencies:

   Make sure you have Bundler installed. Then run:

   ```bash
   bundle install
   ```

3. Run the tests:

   This gem uses RSpec for testing. To run the tests:

   ```bash
   bundle exec rspec
   ```

4. Run Rubocop for code linting

   Ensure your code follows the community Ruby style guide by running Rubocop:
   ```bash
   bundle exec rubocop
   ```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aifoundry-org/rspec-llama. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/aifoundry-org/rspec-llama/blob/master/CODE_OF_CONDUCT.md).

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.

## Code of Conduct

Everyone interacting in the Rspec::Llama project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/aifoundry-org/rspec-llama/blob/master/CODE_OF_CONDUCT.md).
