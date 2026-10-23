# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Essence::ParagraphComponent, type: :component do
  let(:content) { 'Typography content' }
  let(:build_component) { ->(**options) { described_class.new(**options).with_content(content) } }

  it 'renders the component' do
    render_inline(described_class.new) do
      content
    end

    expect(page).to have_css 'body > div.paragraph', exact_text: content, count: 1
  end

  it 'passes the external link icon to the Stimulus controller' do
    render_inline(described_class.new) do
      content
    end

    external_icon = page.find('body > div.paragraph')['data-paragraph-external-icon-value']

    expect(external_icon).to match_icon('arrow_up_right_from_square')
  end

  it_behaves_like 'a component with html options', 'body > div.paragraph'
  it_behaves_like 'a component with a Stimulus controller', 'body > div.paragraph', 'paragraph'
end
