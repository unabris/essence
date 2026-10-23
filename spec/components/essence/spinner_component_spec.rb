# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Essence::SpinnerComponent, type: :component do
  let(:build_component) { ->(**options) { described_class.new(**options) } }

  it 'renders the component' do
    render_inline(described_class.new)

    expect(page).to have_css "body > span.spinner[style='--spinner-size: 40px;']", count: 1
  end

  it 'renders with the given :size' do
    render_inline(described_class.new(size: 22))

    expect(page).to have_css "body > span.spinner[style='--spinner-size: 22px;']", count: 1
  end

  it 'falls back to the default size when :size is not an integer' do
    render_inline(described_class.new(size: '22'))

    expect(page).to have_css "body > span.spinner[style='--spinner-size: 40px;']", count: 1
  end

  it 'appends the given :style to the size' do
    render_inline(described_class.new(style: 'color: red;'))

    expect(page).to have_css "body > span.spinner[style='--spinner-size: 40px; color: red;']", count: 1
  end

  it_behaves_like 'a component with html options', 'body > span.spinner'
end
