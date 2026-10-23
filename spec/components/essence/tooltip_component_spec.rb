# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Essence::TooltipComponent, type: :component do
  let(:text) { 'Tooltip text' }
  let(:build_component) { ->(**options) { described_class.new(text:, **options) } }

  it 'renders the component' do
    render_inline(described_class.new(text:))

    expect(page.find("body > span.tooltip > svg.tooltip-icon[data-tooltip-target='icon']")).to match_icon('circle_info')
    expect(page).to have_css "body > span.tooltip > span.tooltip-bubble[data-tooltip-target='bubble']",
                             exact_text: text, count: 1
    expect(page).to have_css "span.tooltip-bubble > span.tooltip-arrow[data-tooltip-target='arrow']", count: 1
  end

  it_behaves_like 'a component with html options', 'body > span.tooltip'
  it_behaves_like 'a component with a Stimulus controller', 'body > span.tooltip', 'tooltip'
end
