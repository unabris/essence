# frozen_string_literal: true

module Essence
  #
  # @hidden
  #
  # @logical_path components
  #
  class FlashComponentPreview < ViewComponent::Preview
    def default
      render(FlashComponent.new)
    end
  end
end
