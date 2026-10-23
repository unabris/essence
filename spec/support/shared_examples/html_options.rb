# frozen_string_literal: true

# The host group must define `build_component`, a lambda that takes html options and returns the component.
RSpec.shared_examples 'a component with html options' do |root_selector|
  it 'adds the given :html_options to the root element, keeping its own classes' do
    render_inline(build_component.call(id: 'custom-id', class: 'custom-class', data: { john: 'doe' }))

    expect(page).to have_css "#{root_selector}#custom-id.custom-class[data-john='doe']", count: 1
  end
end

# The host group must define `build_component`, a lambda that takes html options and returns the component.
RSpec.shared_examples 'a component with a Stimulus controller' do |root_selector, controller|
  it "connects the `#{controller}` controller" do
    render_inline(build_component.call)

    expect(page).to have_css "#{root_selector}[data-controller='#{controller}']", count: 1
  end

  it 'keeps its own controller when another one is given' do
    render_inline(build_component.call(data: { controller: 'custom' }))

    expect(page).to have_css "#{root_selector}[data-controller='#{controller} custom']", count: 1
  end
end
