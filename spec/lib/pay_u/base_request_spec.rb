# frozen_string_literal: true

require 'pay_u/base_request'

RSpec.describe PayU::BaseRequest do
  subject { described_class.new(headers, options) }
  let(:headers) { {} }

  context "when no options are passed" do
    let(:options) { {} }

    it { expect(subject.class).to eq described_class }
  end

  context "when options are passed" do
    context "when they containing one word is passed" do
      let(:key) { :test }
      let(:value) { "Oh really?" }
      let(:options) { { key => value } }
      let(:expected_result) { { key => value } }

      it { expect(subject.send(key)).to eq value }
      it { expect(subject.to_h).to eq(expected_result) }
    end

    context "when an option containing two words is passed" do
      let(:key) { :test_key }
      let(:value) { "Oh really?" }
      let(:options) { { key => value } }
      let(:expected_result) { { testKey: value } }

      it { expect(subject.send(key)).to eq value }
      it { expect(subject.to_h).to eq(expected_result) }
    end

    context "when an option containing two words is passed" do
      let(:key) { :test_key }
      let(:inner_key) { :inner_test_key }
      let(:inner_value) { "Oh really?" }
      let(:value) { [{ inner_key => inner_value}] }
      let(:options) { { key => value } }
      let(:expected_result) { { testKey: [{ innerTestKey: inner_value }] } }

      it { expect(subject.send(key)).to eq value }
      it { expect(subject.to_h).to eq(expected_result) }
    end
  end
end

