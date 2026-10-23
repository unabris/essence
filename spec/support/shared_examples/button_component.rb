# frozen_string_literal: true

RSpec.shared_examples 'button component' do |variant|
  root_selector = "body > button.button.button-#{variant}"

  let(:name) { 'Button text' }
  let(:build_component) { ->(**options) { described_class.new(name:, variant:, **options) } }

  it 'renders the component' do
    render_inline(build_component.call)

    expect(page).to have_css "#{root_selector}[type='submit']", count: 1
    expect(page).to have_css "#{root_selector} > span.spinner.button-spinner", count: 1
    expect(page).to have_css "#{root_selector} > span", exact_text: name, count: 1
    expect(page).to have_no_css "#{root_selector}.button-busy"
  end

  it_behaves_like 'a component with html options', root_selector
  it_behaves_like 'a component with a Stimulus controller', root_selector, 'button'
  it_behaves_like 'a component with icon slots', root_selector, 'button-icon'
end
