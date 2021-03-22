# frozen_string_literal: true

module Schienenzeppelin
  RSpec.describe AddOn do
    describe 'apply' do
      let(:clazz) { Class.new(AddOn) }

      it 'should apply' do
        expect_any_instance_of(clazz).to receive(:apply)

        clazz.apply
      end

      context 'with skip option' do
        it 'should skip apply' do
          expect_any_instance_of(clazz).not_to receive(:apply)

          clazz.apply({ skip_class: true })
        end
      end

      context 'with dependency' do
        let(:clazz) { Class.new(AddOn) { depends_on(:another) } }

        it 'should apply' do
          expect_any_instance_of(clazz).to receive(:apply)

          clazz.apply
        end

        it 'skips apply' do
          expect_any_instance_of(clazz).not_to receive(:apply)

          clazz.apply({ skip_another: true })
        end
      end
    end
  end
end
