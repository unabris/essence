# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Essence::CardComponent, type: :component do
  let(:headline) { 'Card headline' }
  let(:sub_headline) { 'Card sub headline' }
  let(:content) { 'Card content' }
  let(:build_component) { ->(**options) { described_class.new(**options).with_content(content) } }

  it 'renders the component' do
    render_inline(described_class.new(headline:)) do
      content
    end

    expect(page).to have_css 'body > div.card > h2.card-headline', exact_text: headline, count: 1
    expect(page).to have_css 'body > div.card > div.card-content', exact_text: content, count: 1
    expect(page).to have_no_css 'body > div.card > p.card-sub-headline'
    expect(page).to have_no_css 'body > div.card > div.card-ribbon'
  end

  it 'renders without the headline' do
    render_inline(described_class.new) do
      content
    end

    expect(page).to have_no_css 'body > div.card > h2.card-headline'
    expect(page).to have_css 'body > div.card > div.card-content', exact_text: content, count: 1
  end

  it 'renders with the given :sub_headline' do
    render_inline(described_class.new(headline:, sub_headline:)) do
      content
    end

    expect(page).to have_css 'body > div.card > h2.card-headline + p.card-sub-headline', exact_text: sub_headline,
                                                                                         count: 1
  end

  it 'renders nothing without content' do
    render_inline(described_class.new(headline:))

    expect(rendered_content).to be_blank
  end

  it_behaves_like 'a component with html options', 'body > div.card'

  describe 'ribbon' do
    it 'renders the light ribbon by default' do
      render_inline(described_class.new(headline:)) do |card|
        card.with_ribbon(text: 'New')
        content
      end

      ribbon = page.find('body > div.card > div.card-ribbon.card-ribbon-light:first-child')

      expect(ribbon).to have_css 'span.card-ribbon-text', exact_text: 'New', count: 1
    end

    it 'renders the dark ribbon with `variant: :dark`' do
      render_inline(described_class.new) do |card|
        card.with_ribbon(text: 'New', variant: :dark)
        content
      end

      expect(page).to have_css 'body > div.card > div.card-ribbon.card-ribbon-dark > span.card-ribbon-text',
                               exact_text: 'New', count: 1
    end

    it 'renders the ribbon with the given :html_options' do
      render_inline(described_class.new) do |card|
        card.with_ribbon(text: 'New', class: 'custom-class', data: { john: 'doe' })
        content
      end

      expect(page).to have_css "body > div.card > div.card-ribbon.card-ribbon-light.custom-class[data-john='doe']",
                               count: 1
    end

    it 'raises an error with an invalid :variant' do
      expect { described_class::RibbonComponent.new(text: 'New', variant: :invalid) }
        .to raise_error(Essence::FetchOrFallbackHelper::InvalidValueError)
    end
  end
end
