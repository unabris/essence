# frozen_string_literal: true

module Essence
  #
  # @logical_path components
  #
  # @display wrapper card
  #
  class ChecklistComponentPreview < ViewComponent::Preview
    def default(title: 'Customize your website\'s design')
      render Essence::ChecklistComponent.new(title:) do |checklist|
        checklist.with_items([
                               {
                                 name: 'Select a theme',
                                 url: '#',
                                 completed: true
                               },
                               {
                                 name: 'Upload your logo',
                                 url: '#',
                                 completed: false
                               },
                               {
                                 name: 'Define your color palette',
                                 url: '#',
                                 completed: false
                               }
                             ])
      end
    end
  end
end
