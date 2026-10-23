# frozen_string_literal: true

module Essence
  #
  # @hidden
  #
  # @logical_path components
  #
  class ButtonGroupComponentPreview < ViewComponent::Preview
    def default
      render(ButtonGroupComponent.new)
    end
  end
end
