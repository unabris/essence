# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Essence::LinkComponent, type: :component do
  let(:name) { 'Link text' }

  [:primary, :secondary, :danger].each do |variant|
    context "with `variant: :#{variant}`" do
      it_behaves_like 'link component', variant
    end
  end

  it 'uses the primary variant by default' do
    render_inline(described_class.new(name:, url: '/some/path'))

    expect(page).to have_css "body > a.link.link-primary[href='/some/path']", count: 1
  end

  it 'raises an error with an invalid :variant' do
    expect { described_class.new(name:, url: '/some/path', variant: :invalid) }
      .to raise_error(Essence::FetchOrFallbackHelper::InvalidValueError)
  end

  it 'raises an error with an invalid :display_as' do
    expect { described_class.new(name:, url: '/some/path', display_as: :invalid) }
      .to raise_error(Essence::FetchOrFallbackHelper::InvalidValueError)
  end

  it 'requires the :url' do
    expect { described_class.new(name:) }.to raise_error(ArgumentError, /missing keyword: :url/)
  end

  context 'when invalid values are given in production' do
    before do
      allow(Rails).to receive(:env).and_return(ActiveSupport::EnvironmentInquirer.new('production'))
    end

    it 'falls back to the default :display_as, keeping a valid :variant' do
      render_inline(described_class.new(name:, url: '/some/path', display_as: :invalid, variant: :danger))

      expect(page).to have_css "body > a.link.link-danger[href='/some/path']", count: 1
    end

    it 'falls back to the default :variant when it is not available for the :display_as' do
      render_inline(described_class.new(name:, url: '/some/path', display_as: :invalid, variant: :outline))

      expect(page).to have_css "body > a.link.link-primary[href='/some/path']", count: 1
    end
  end

  context 'with `display_as: :button`' do
    [:primary, :secondary, :danger, :outline, :copilot].each do |variant|
      context "with `variant: :#{variant}`" do
        it_behaves_like 'link component', variant, display_as: :button
      end
    end

    it 'renders neither the Stimulus controller nor the spinner' do
      render_inline(described_class.new(name:, url: '/some/path', display_as: :button))

      expect(page).to have_no_css 'a[data-controller]'
      expect(page).to have_no_css 'span.spinner'
    end
  end
end
