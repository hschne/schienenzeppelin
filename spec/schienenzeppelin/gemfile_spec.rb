# frozen_string_literal: true

module Schienenzeppelin
  RSpec.describe Gemfile do
    let(:directory) { Dir.mktmpdir }
    let(:gemfile) { File.open("#{directory}/Gemfile", 'w') }

    around(:each) do |test|
      Dir.chdir(directory, &test)
    end

    describe 'add anchor' do
      context 'with empty gemfile' do
        before(:each) do
          File.open(gemfile, 'w') do |f|
            f.write('')
          end
        end

        it 'should add anchor' do
          described_class.add_anchor

          expect(IO.read(gemfile)).to match(/\# Schienenzeppelin/)
        end
      end
    end

    describe 'add' do
      context 'with content' do
        let(:content) {
          <<~HERE
            gem 'first'
            # Schienenzeppelin

            gem 'second'

            group :development, :test do
              gem 'third'
            end

            group :development do
              gem 'development'
            end
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

              group :development, :test do
                gem 'third'
              end

              group :development do
                gem 'development'
              end
            HERE
          }

          it 'should add gem' do
            subject.add('gemname', '~> 1.0', description: 'This is the description')

            expect(IO.read(gemfile)).to eq(expected_content)
          end
        end

        context 'with single group gem' do
          let(:expected_content) {
            <<~HERE
              gem 'first'
              # Schienenzeppelin

              gem 'second'

              group :development, :test do
                gem 'third'
              end

              group :development do
                # This is the description
                gem 'gemname', '~> 1.0'
                gem 'development'
              end
            HERE
          }

          it 'should add gem' do
            subject.add('gemname', '~> 1.0', description: 'This is the description', group: :development)

            expect(IO.read(gemfile)).to eq(expected_content)
          end
        end

        context 'with multi group gem' do
          let(:expected_content) {
            <<~HERE
              gem 'first'
              # Schienenzeppelin

              gem 'second'

              group :development, :test do
                # This is the description
                gem 'gemname', '~> 1.0'
                gem 'third'
              end

              group :development do
                gem 'development'
              end
            HERE
          }

          it 'should add gem' do
            subject.add('gemname', '~> 1.0', description: 'This is the description', group: %i[development test])

            expect(IO.read(gemfile)).to eq(expected_content)
          end
        end
      end
    end
  end
end
