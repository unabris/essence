# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Essence::StepListComponent, type: :component do
  let(:title) { 'Step list title' }
  let(:items) do
    [
      {
        headline: 'Establish a Connection',
        description: 'Connect your device to Wi-Fi or Ethernet and verify by opening a website.'
      },
      {
        headline: 'Launch Your Browser',
        description: 'Open your browser (e.g., Chrome, Firefox) and ensure it\'s up to date.'
      },
      {
        headline: 'Enter the URL',
        description: 'Type the website URL in the address bar and press "Enter".'
      }
    ]
  end
  let(:build_component) { ->(**options) { described_class.new(**options).tap { |list| list.with_items(items) } } }

  it 'renders the component' do
    render_inline(described_class.new(title:)) do |step_list|
      step_list.with_items(items)
    end

    expect(page).to have_css 'body > div.step-list > h4.step-list-title', exact_text: title, count: 1

    step_list_items = page.find('body > div.step-list > div.step-list-items')

    expect(step_list_items).to have_css 'div.step-list-item > div > div.step-list-bubble', count: 3

    items.each.with_index(1) do |item, index|
      step_list_item = step_list_items.find("div.step-list-item:nth-child(#{index})")

      expect(step_list_item).to have_css 'div > strong.step-list-headline', exact_text: item[:headline], count: 1
      expect(step_list_item).to have_css 'div > p.step-list-description', exact_text: item[:description], count: 1
    end
  end

  it 'renders without the title' do
    render_inline(described_class.new) do |step_list|
      step_list.with_items(items)
    end

    expect(page).to have_no_css 'h4.step-list-title'
    expect(page).to have_css 'body > div.step-list > div.step-list-items > div.step-list-item', count: 3
  end

  it 'renders nothing without items' do
    render_inline(described_class.new(title:))

    expect(rendered_content).to be_blank
  end

  it_behaves_like 'a component with html options', 'body > div.step-list'
end
