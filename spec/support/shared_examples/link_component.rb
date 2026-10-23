# frozen_string_literal: true

RSpec.shared_examples 'link component' do |variant, display_as: :link|
  url           = '/some/path'
  root_selector = "body > a.#{display_as}.#{display_as}-#{variant}[href='#{url}']"

  let(:name) { 'Link text' }
  let(:build_component) { ->(**options) { described_class.new(name:, url:, variant:, display_as:, **options) } }

  it 'renders the component' do
    render_inline(build_component.call)

    expect(page).to have_css "#{root_selector} > span", exact_text: name, count: 1
  end

  it_behaves_like 'a component with html options', root_selector
  it_behaves_like 'a component with icon slots', root_selector, 'link-icon'
end
