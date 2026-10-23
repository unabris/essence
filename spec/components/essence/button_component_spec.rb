# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Essence::ButtonComponent, type: :component do
  let(:name) { 'Button text' }

  [:primary, :secondary, :danger, :outline, :copilot].each do |variant|
    context "with `variant: :#{variant}`" do
      it_behaves_like 'button component', variant
    end
  end

  it 'uses the primary variant by default' do
    render_inline(described_class.new(name:))

    expect(page).to have_css 'body > button.button.button-primary', count: 1
  end

  it 'renders as busy with `busy: true`' do
    render_inline(described_class.new(name:, busy: true))

    expect(page).to have_css 'body > button.button.button-primary.button-busy', count: 1
  end

  it 'does not render as busy when :busy is not a boolean' do
    render_inline(described_class.new(name:, busy: 'yes'))

    expect(page).to have_no_css 'button.button-busy'
  end

  it 'renders inside a form with the given :url' do
    render_inline(described_class.new(name:, url: '/some/path'))

    expect(page).to have_css "body > form.button_to[action='/some/path'][method='post'] > " \
                             "button.button.button-primary[type='submit'][data-controller='button'] > span",
                             exact_text: name, count: 1
  end

  it 'raises an error with an invalid :variant' do
    expect { described_class.new(name:, variant: :invalid) }
      .to raise_error(Essence::FetchOrFallbackHelper::InvalidValueError)
  end

  it 'raises an error with an invalid :display_as' do
    expect { described_class.new(name:, display_as: :invalid) }
      .to raise_error(Essence::FetchOrFallbackHelper::InvalidValueError)
  end

  context 'when invalid values are given in production' do
    before do
      allow(Rails).to receive(:env).and_return(ActiveSupport::EnvironmentInquirer.new('production'))
    end

    it 'falls back to the default :display_as, keeping a valid :variant' do
      render_inline(described_class.new(name:, display_as: :invalid, variant: :danger))

      expect(page).to have_css "body > button.button.button-danger[data-controller='button']", count: 1
    end

    it 'falls back to the default :variant when it is not available for the :display_as' do
      render_inline(described_class.new(name:, display_as: :link, variant: :outline))

      expect(page).to have_css 'body > button.link.link-primary', count: 1
    end
  end

  context 'with `display_as: :link`' do
    [:primary, :secondary, :danger].each do |variant|
      it "renders the button as a link with `variant: :#{variant}`" do
        render_inline(described_class.new(name:, variant:, display_as: :link))

        expect(page).to have_css "body > button.link.link-#{variant} > span", exact_text: name, count: 1
      end
    end

    it 'renders neither the Stimulus controller nor the spinner' do
      render_inline(described_class.new(name:, display_as: :link))

      expect(page).to have_no_css 'button[data-controller]'
      expect(page).to have_no_css 'span.spinner'
    end

    it 'ignores `busy: true`' do
      render_inline(described_class.new(name:, display_as: :link, busy: true))

      expect(page).to have_no_css 'button.button-busy'
    end

    it 'raises an error with a button-only :variant' do
      expect { described_class.new(name:, variant: :outline, display_as: :link) }
        .to raise_error(Essence::FetchOrFallbackHelper::InvalidValueError)
    end
  end
end
