# frozen_string_literal: true

module Essence
  #
  # @hidden
  #
  # @logical_path components
  #
  # @display wrapper card
  #
  class TableComponentPreview < ViewComponent::Preview
    def default
      render Essence::TableComponent.new(rows: User.all.sample(10)) do |table|
        table.column('Email', &:email)
        table.column('First Name', &:first_name)
        table.column('Last Name', &:last_name)
      end
    end
  end
end
