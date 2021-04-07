# frozen_string_literal: true

module Schienenzeppelin
  RSpec.describe Dependencies do
    let(:clazz) { Class.new(AddOn) }
    let(:dependency) { Class.new(AddOn) }

    before(:each) do
      stub_const('Schienenzeppelin::AddOns::Dummy', clazz)
      stub_const('Schienenzeppelin::AddOns::Dependency', dependency)
    end

    describe 'satisified' do
      context 'with addon dependency' do
        let(:clazz) { Class.new(AddOn) { depends_on :dependency } }
        let(:dependency) { Class.new(AddOn) }

        it 'should return false if dependency skipped' do
          dependencies = Dependencies.new(clazz, Context.new({ skip_dependency: true }))

          expect(dependencies.satisfied?).to be false
        end

        it 'should return true if not skipped' do
          dependencies = Dependencies.new(clazz, Context.new({ skip_dependency: false }))

          expect(dependencies.satisfied?).to be true
        end
      end

      context 'with default dependency' do
        let(:clazz) { Class.new(AddOn) { depends_on :active_record } }

        it 'should return false if dependency skipped' do
          dependencies = Dependencies.new(clazz, Context.new({ skip_active_record: true }))

          expect(dependencies.satisfied?).to be false
        end

        it 'should return true if dependency not skipped' do
          dependencies = Dependencies.new(clazz, Context.new({ skip_active_record: false }))

          expect(dependencies.satisfied?).to be true
        end
      end
    end
  end
end
