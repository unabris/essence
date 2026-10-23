# frozen_string_literal: true

RSpec.shared_examples 'notification component' do |variant, css_class:, icon:|
  root_selector = "body > div.notification.#{css_class}"

  let(:content) { 'Notification text' }
  let(:build_component) { ->(**options) { described_class.new(variant:, **options).with_content(content) } }

  it 'renders the component' do
    render_inline(build_component.call)

    expect(page).to have_css root_selector, count: 1
    expect(page.find("#{root_selector} > div.notification-indicator > svg.notification-icon")).to match_icon(icon)
    expect(page).to have_css "#{root_selector} > div.notification-body", exact_text: content, count: 1
  end

  it_behaves_like 'a component with html options', root_selector
end
