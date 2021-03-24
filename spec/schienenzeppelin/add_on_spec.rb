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

      context 'with new gemfile' do
        let(:directory) { Dir.mktmpdir }
        let(:gemfile) { File.open("#{directory}/Gemfile", 'w') }
        let(:addon) { Class.new(AddOn) { gem('gemname') } }
        before(:each) { File.open(gemfile, 'w') }

        it 'should add anchor' do
          expect_any_instance_of(addon).to receive(:apply)

          Dir.chdir(directory) { addon.apply }

          expect(IO.read(gemfile)).to match(/\# Schienenzeppelin/)
        end
      end

      context 'with gemfile' do
        let(:directory) { Dir.mktmpdir }

        let(:gemfile) { File.open("#{directory}/Gemfile", 'w') }

        let(:content) {
          <<~HERE
            gem 'first'
            # Schienenzeppelin

            gem 'second'
          HERE
        }

        before(:each) do
          File.open(gemfile, 'w') do |f|
            f.write(content)
          end
        end

        context 'with gem' do
          let(:addon) { Class.new(AddOn) { gem('gemname', '~> 1.0', description: 'This is the description') } }

          let(:expected_content) {
            <<~HERE
              gem 'first'
              # Schienenzeppelin
              # This is the description
              gem 'gemname', '~> 1.0'

              gem 'second'
            HERE
          }

          it 'should add gem' do
            expect_any_instance_of(addon).to receive(:apply)

            Dir.chdir(directory) { addon.apply }

            expect(IO.read(gemfile)).to eq(expected_content)
          end
        end
      end
    end
  end
end
