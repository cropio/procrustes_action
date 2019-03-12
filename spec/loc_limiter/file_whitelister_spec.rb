# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LocLimiter::FileWhitelister do
  let(:service) { described_class.new }

  describe '#match?' do
    subject { service.match?(filename) }

    context 'rb file match' do
      let(:filename) { 'app/models/field.rb' }
      it { is_expected.to eq(true) }
    end

    context 'slim file match' do
      let(:filename) { 'app/views/fields/index.slim' }
      it { is_expected.to eq(true) }
    end

    context 'html file match' do
      let(:filename) { 'app/views/fields/index.json' }
      it { is_expected.to eq(true) }
    end

    context 'jsx file match' do
      let(:filename) { 'app/javascript/main.jsx' }
      it { is_expected.to eq(true) }
    end

    context 'es6 file match' do
      let(:filename) { 'app/javascript/main.es6' }
      it { is_expected.to eq(true) }
    end

    context 'es6 file match' do
      let(:filename) { 'app/javascript/main.js' }
      it { is_expected.to eq(true) }
    end

    context 'css file match' do
      let(:filename) { 'app/assets/stylesheets/field.css' }
      it { is_expected.to eq(true) }
    end

    context 'rspec file does not match' do
      let(:filename) { 'spec/models/field_spec.rb' }
      it { is_expected.to eq(false) }
    end

    context 'config file does not match' do
      let(:filename) { 'config/application.rb' }
      it { is_expected.to eq(false) }
    end

    context 'config file in the middle' do
      let(:filename) { 'app/config/application.rb' }
      it { is_expected.to eq(true) }
    end

    context 'public file does not match' do
      let(:filename) { 'public/404.html' }
      it { is_expected.to eq(false) }
    end
  end
end
