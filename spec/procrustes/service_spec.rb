# frozen_string_literal: true

require 'spec_helper'

def load_fixture(path)
  JSON.parse(File.read('./spec/fixtures/' + path))
end

RSpec.describe Procrustes::Service do
  let(:github) { instance_double('Octokit::Client') }
  let(:selector) { Procrustes::FileWhitelister.new }
  let(:service) { described_class.new(github: github, file_selector: selector) }

  describe '#perform!' do
    subject(:action) { service.perform!(payload) }

    let(:payload) { load_fixture('pull_request.event.json') }

    let(:compare_args) do
      [
        'ozeron/amazone_service',
        '533b99d5e676ba7303d0f9bfb6101b8d47cab689',
        'a930751d19af64b9fcc737b7f9ff294152174472'
      ]
    end

    before do
      allow(github).to(
        receive(:compare).with(*compare_args).and_return(compare_data)
      )
    end

    context 'when additions less than ADDITIONS_MAX_NUM' do
      let(:compare_data) { load_fixture('compare.success.json') }
      let(:success_args) do
        [
          'ozeron/amazone_service',
          'a930751d19af64b9fcc737b7f9ff294152174472',
          'success',
          {
            context: 'PR size check',
            description: 'Checked LOC – It smaller than 1000'
          }
        ]
      end

      it 'return true' do
        expect(action).to eq(true)
      end
    end

    context 'when additions more than ADDITIONS_MAX_NUM' do
      let(:compare_data) { load_fixture('compare.failure.json') }

      it 'return false' do
        expect(action).to eq(false)
      end
    end
  end
end
