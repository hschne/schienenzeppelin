# frozen_string_literal: true

RSpec.describe Schienenzeppelin do
  it 'has a version number' do
    expect(Schienenzeppelin::VERSION).not_to be nil
  end

  context 'in new directory' do
    let(:directory) { Dir.mktmpdir }

    before(:each) do
      templates_root = File.expand_path(File.join('..', 'templates'), File.dirname(__FILE__))
      Schienenzeppelin::AppGenerator.source_root templates_root
      Schienenzeppelin::AppGenerator.source_paths << Rails::Generators::AppGenerator.source_root << templates_root
      Dir.chdir(directory)
    end

    skip 'should set up app' do
      result, code, * = Schienenzeppelin::AppGenerator.start ['testapp'], destination_root: directory

      expect(result).to be(nil)
    end
  end
end
