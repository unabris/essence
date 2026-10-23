# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Essence::ScrollShadowComponent, type: :component do
  let(:content) { 'Scroll Shadow content' }
  let(:build_component) { ->(**options) { described_class.new(**options).with_content(content) } }

  it 'renders the component' do
    render_inline(described_class.new) do
      content
    end

    expect(page).to have_css 'body > scroll-shadow > div.scroll-shadow', exact_text: content, count: 1
  end

  it_behaves_like 'a component with html options', 'body > scroll-shadow > div.scroll-shadow'
end
