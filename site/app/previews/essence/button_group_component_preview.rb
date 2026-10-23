# frozen_string_literal: true

module Essence
  class ButtonGroupComponentPreview < ViewComponent::Preview
    #
    # @hidden
    #
    # @logical_path components
    #
    def default
      render(ButtonGroupComponent.new)
    end
  end
end
