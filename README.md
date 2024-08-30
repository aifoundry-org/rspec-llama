# RSpec::Llama

[![Gem Version](https://badge.fury.io/rb/rspec-llama.svg)](https://badge.fury.io/rb/rspec-llama)
[![Build Status](https://github.com/aifoundry-org/rspec-llama/actions/workflows/rspec-llama.yml/badge.svg)](https://github.com/aifoundry-org/rspec-llama/actions)

## Introduction

**RSpec::Llama** is a versatile testing framework designed to integrate AI model testing seamlessly into the RSpec ecosystem. Whether you're working with OpenAI's GPT models, Llama, or other AI models, RSpec::Llama simplifies the process of configuring, running, and validating your models' outputs.

## Features

- **Model Configurations**: Easily set up configurations for different AI models like OpenAI, Llama, and Ollama.
- **Model Runners**: Execute model interactions and capture responses seamlessly.
- **Comprehensive Assertions**: Validate model outputs against expected patterns using a variety of assertion types.

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

### `build_model_prompt(message)`

The `build_model_prompt` helper is used to create a ModelPrompt object, which represents the prompt or input that
you want to send to an AI model. This helper is essential for passing user queries or instructions to the model runner.

Parameters:

`message`: A string containing the text of the prompt that you want to send to the model.

Examples:
```ruby
# Simple Text Prompt
prompt = build_model_prompt('What is the capital of France?')

# Example usage with a model runner
config = build_model_configuration(:openai, model: 'gpt-3.5-turbo')
runner = build_model_runner(:openai, access_token: ENV['OPENAI_ACCESS_TOKEN'])
result = runner.call(config, prompt)
puts result # Expected output: "The capital of France is Paris."
```

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

```ruby
config = build_model_configuration(:openai, model: 'gpt-4', temperature: 0.7)

# Example usage
model_runner = build_model_runner(:openai, access_token: ENV['OPENAI_ACCESS_TOKEN'])
prompt = build_model_prompt('What is the capital of France?')
result = model_runner.call(config, prompt)
```

#### LlamaCpp Model Configuration

The LlamaCpp model configuration is used to set parameters for models running with the llama.cpp implementation.

```ruby
config = build_model_configuration(:llama_cpp, model: '/path/to/model', temperature: 0.5, predict: 500)

# Example usage
model_runner = build_model_runner(:llama_cpp, cli_path: '/path/to/llama-cli')
prompt = build_model_prompt('Describe the Eiffel Tower.')
result = model_runner.call(config, prompt)
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
model_runner = build_model_runner(:ollama)
prompt = build_model_prompt('What are the benefits of using Ruby?')
result = model_runner.call(config, prompt)
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
prompt = build_model_prompt('What is the capital of France?')
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

### `build_model_assertion(assertion_type, value, *other_values)`

The helper method is used to create assertions that validate the model's output. Depending on the `assertion_type`, the method checks whether certain values are included, excluded, or matched in the model's response.

Parameters:

`assertion_type`: The type of assertion to create. It can be one of the following: `:include_all`, `:include_any`, `:exclude_all`.

`value`: The primary value or pattern to assert. Can be a String or Regexp.

`*other_values`: Additional values or patterns to include in the assertion.

Returns: An assertion object that can be used to validate the model's output.

#### `:include_all` Assertion

This assertion checks that all specified values or patterns are present in the model's output.

```ruby
assertion = build_model_assertion(:include_all, 'France', 'Paris')
runner_result = "The capital of France is Paris."

result = assertion.call(runner_result)
result.passed? # true
result.failed? # false
```

In this example, the assertion passes because both 'France' and 'Paris' are found in the output.

#### `:include_any` Assertion

This assertion checks that at least one of the specified values or patterns is present in the model's output.

```ruby
assertion = build_model_assertion(:include_any, 'London', 'Paris')
runner_result = "The capital of France is Paris."

result = assertion.call(runner_result)
result.passed? # true
result.failed? # false
```

#### `:exclude_all` Assertion

This assertion checks that none of the specified values or patterns are present in the model's output.

```ruby
assertion = build_model_assertion(:exclude_all, 'London', 'Berlin')
runner_result = "The capital of France is Paris."

result = assertion.call(runner_result)
result.passed? # true
result.failed? # false
```

#### Advanced Usage with Regular Expressions:

You can also use regular expressions instead of plain strings for more complex assertions.

```ruby
assertion = build_model_assertion(:include_all, /France/, /Paris/)
runner_result = "The capital of France is Paris."

result = assertion.call(runner_result)
result.passed? # true
result.failed? # false
```

In this case, the assertion uses regular expressions to check that both 'France' and 'Paris' match parts of the output string.

#### The assertion result object

It represents the outcome of an assertion check against a model's output.
It provides two methods `passed?` and `failed?` to evaluate whether the assertion passed or failed.

```ruby
assertion = build_model_assertion(:include_all, 'France', 'Paris')
assertion_result = assertion.call('The capital of France is Paris.')

expect(assertion_result).to be_passed
expect(assertion_result).not_to be_failed
```

## Full Example: Testing with OpenAI Models

Here’s a full example that demonstrates how to use helpers to test various OpenAI models with different configurations and assertions.

```ruby
require 'rspec/llama'

RSpec.describe 'OpenAI models' do
  subject(:assertion_result) { assertion.call(runner_result) }

  let(:prompt) { build_model_prompt('Is Minsk the capital of Belarus?') }
  let(:assertion) { build_model_assertion(:include_any, 'Yes') }
  let(:runner_result) { model_runner.call(model_configuration, prompt) }

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
