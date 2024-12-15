# frozen_string_literal: true

module Essence
  class ChecklistComponent < ApplicationComponent
    attr_reader :title, :html_options

    renders_many :items, 'ItemComponent'

    def initialize(title: nil,
                   **html_options)
      @title        = title
      @html_options = html_options
    end

    class ItemComponent < ApplicationComponent
      attr_reader :name, :url, :icon

      DEFAULT_COMPLETED = false

      COMPLETED_MAPPINGS = {
        true => 'todo_check',
        DEFAULT_COMPLETED => 'todo_circle'
      }.freeze

      def initialize(name:, url:, completed: false)
        @name      = name
        @url       = url
        @completed = completed
      end

      private

      def before_render
        set_icon
      end

      def set_icon
        @icon = COMPLETED_MAPPINGS[@completed]
      end
    end

    private

    def before_render
      set_base_html_options('checklist')
    end

    def render?
      items.any?
    end
  end
end
