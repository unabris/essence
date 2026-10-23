# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Essence::TitleComponent, type: :component do
  let(:text) { 'Title text' }
  let(:build_component) { ->(**options) { described_class.new(text:, **options) } }

  it 'renders the component' do
    render_inline(described_class.new(text:))

    expect(page).to have_css 'body > h1.title', exact_text: text, count: 1
  end

  it_behaves_like 'a component with html options', 'body > h1.title'

  ['', '   ', nil].each do |blank_text|
    it "renders nothing with `text: #{blank_text.inspect}`" do
      render_inline(described_class.new(text: blank_text))

      expect(rendered_content).to be_blank
    end
  end
end
