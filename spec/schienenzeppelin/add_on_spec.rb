# frozen_string_literal: true

module Schienenzeppelin
  RSpec.describe AddOn do
    let(:clazz) { Class.new(AddOn) }

    describe 'uses' do
      it 'should return false if skipped default' do
        addon = AddOn.new(Context.new({ skip_active_record: true }))

        expect(addon.uses?(:active_record)).to be false
      end

      it 'should return true not skipped default' do
        addon = AddOn.new(Context.new({ skip_active_record: false }))

        expect(addon.uses?(:active_record)).to be true
      end
    end

    describe 'apply' do
      let(:clazz) { Class.new(AddOn) }

      before(:each) do
        stub_const('Schienenzeppelin::AddOns::Class', clazz)
      end

      it 'should apply' do
        expect_any_instance_of(clazz).to receive(:apply)

        clazz.apply
      end

      context 'with skip option' do
        it 'should skip apply' do
          expect_any_instance_of(clazz).not_to receive(:apply)

          clazz.apply(Context.new({ skip_class: true }))
        end
      end

      context 'with dependency' do
        let(:clazz) { Class.new(AddOn) { depends_on(:another) } }

        it 'should apply' do
          stub_const('Schienenzeppelin::AddOns::Another', Class.new(AddOn))
          expect_any_instance_of(clazz).to receive(:apply)

          clazz.apply
        end

        it 'skips apply' do
          stub_const('Schienenzeppelin::AddOns::Another', Class.new(AddOn))
          expect_any_instance_of(clazz).not_to receive(:apply)

          clazz.apply(Context.new({ skip_another: true }))
        end
      end
    end
  end
end
