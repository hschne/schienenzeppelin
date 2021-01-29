# frozen_string_literal: true

module Schienenzeppelin
  module Generators
    class Credentials < GeneratorBase
      def create_credentials
        create_credential_files('config/master.key', 'config/credentials.yml.enc')
        create_credential_files('config/credentials/production.key', 'config/credentials/production.yml.enc')

      end

      private

      def create_credential_files(key_path, file_path)
        encryption_key_file_generator.add_key_file(key_path)
        require 'active_support/encrypted_file'
        ActiveSupport::EncryptedFile.new(
          content_path: file_path,
          key_path: key_path,
          env_key: 'RAILS_MASTER_KEY',
          raise_if_missing_key: true
        ).write(credentials_template)
      end

      def encryption_key_file_generator
        require 'rails/generators/rails/encrypted_file/encrypted_file_generator'
        Rails::Generators::EncryptionKeyFileGenerator.new
      end

      def credentials_template
        context = instance_eval('binding', __FILE__, __LINE__)
        source = File.expand_path(find_in_source_paths('config/credentials.yml.erb'))
        match = ERB.version.match(/(\d+\.\d+\.\d+)/)
        capturable_erb = if match && match[1] >= '2.2.0' # Ruby 2.6+
                           CapturableERB.new(::File.binread(source), trim_mode: '-', eoutvar: '@output_buffer')
                         else
                           CapturableERB.new(::File.binread(source), nil, '-', '@output_buffer')
                         end
        capturable_erb.tap do |erb|
          erb.filename = source
        end.result(context)
      end
    end
  end
end
