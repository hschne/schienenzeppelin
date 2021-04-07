# frozen_string_literal: true

module Schienenzeppelin
  RSpec.describe Context do
    describe 'addons' do
      it 'should return available addons' do
        expect(subject.addons).not_to be_empty
      end
    end

    describe 'default_addons' do
      it 'should return default addons' do
        expect(subject.default_addons).not_to be_empty
      end
    end
  end
end
