# frozen_string_literal: true

module Schienenzeppelin
  module Helpers
    class Credentials < HelperBase
      def apply
        key_path = Pathname.new('config/credentials/production.key')
        create_credential_files(key_path, 'config/credentials/production.yml.enc')
      end

      private

      def create_credential_files(key_path, file_path)
        key = ActiveSupport::EncryptedFile.generate_key
        encryption_key_file_generator.add_key_file_silently(key_path, key)
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
        capturable_erb = capturable_erb(match, source)
        capturable_erb.tap do |erb|
          erb.filename = source
        end.result(context)
      end

      def capturable_erb(match, source)
        if match && match[1] >= '2.2.0' # Ruby 2.6+
          CapturableERB.new(::File.binread(source), trim_mode: '-', eoutvar: '@output_buffer')
        else
          CapturableERB.new(::File.binread(source), nil, '-', '@output_buffer')
        end
      end
    end
  end
end
