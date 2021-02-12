# frozen_string_literal: true

module Rails
  class NavigationGenerator < Rails::Generators::NamedBase
    def add_link
      append_to_file 'app/views/shared/_navbar.html.erb',
                     after: '<!-- SZ Link Placeholder -->' do
        <<-HTML

        <%= link_to "#{plural_name.capitalize}", #{plural_name}_path, class: "block md:inline-block p-3 border-b-2 border-gray-100 md:border-none" %>
        HTML
      end
    end
  end
end
