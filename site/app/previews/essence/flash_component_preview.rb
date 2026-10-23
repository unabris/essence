# frozen_string_literal: true

module Essence
  class FlashComponentPreview < ViewComponent::Preview
    #
    # @hidden
    #
    # @logical_path components
    #
    def default
      render(FlashComponent.new)
    end
  end
end
