# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Essence::StatusComponent, type: :component do
  [:outline, :todo, :active, :danger].each do |variant|
    context "with `variant: :#{variant}`" do
      it_behaves_like 'status component', variant
    end
  end

  it 'uses the outline variant by default' do
    render_inline(described_class.new(text: 'Status text'))

    expect(page).to have_css 'body > div.status.status-outline', count: 1
  end

  it 'strips and downcases the given :text' do
    render_inline(described_class.new(text: "  Status TEXT \n"))

    expect(page).to have_css 'body > div.status', exact_text: 'status text', count: 1
  end

  ['', '   ', nil].each do |text|
    it "renders nothing with `text: #{text.inspect}`" do
      render_inline(described_class.new(text:))

      expect(rendered_content).to be_blank
    end
  end

  it 'raises an error with an invalid :variant' do
    expect { described_class.new(text: 'Status text', variant: :invalid) }
      .to raise_error(Essence::FetchOrFallbackHelper::InvalidValueError)
  end

  it 'raises an error with an invalid :bubble' do
    expect { described_class.new(text: 'Status text', bubble: :invalid) }
      .to raise_error(Essence::FetchOrFallbackHelper::InvalidValueError)
  end
end
