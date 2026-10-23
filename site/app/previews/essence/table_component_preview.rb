# frozen_string_literal: true

module Essence
  #
  # @logical_path components
  #
  # @display wrapper card
  #
  class TableComponentPreview < ViewComponent::Preview
    User = Data.define(:email, :first_name, :last_name)

    USERS = [
      User.new(email: 'john.doe@example.com', first_name: 'John', last_name: 'Doe'),
      User.new(email: 'jane.roe@example.com', first_name: 'Jane', last_name: 'Roe'),
      User.new(email: 'max.mustermann@example.com', first_name: 'Max', last_name: 'Mustermann')
    ].freeze

    def default
      render Essence::TableComponent.new(rows: USERS) do |table|
        table.column('Email', &:email)
        table.column('First Name', &:first_name)
        table.column('Last Name', &:last_name)
      end
    end
  end
end
