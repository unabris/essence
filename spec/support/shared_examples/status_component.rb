# frozen_string_literal: true

RSpec.shared_examples 'status component' do |variant|
  root_selector = "body > div.status.status-#{variant}"

  let(:text) { 'Status text' }
  let(:build_component) { ->(**options) { described_class.new(text:, variant:, **options) } }

  it 'renders the component' do
    render_inline(build_component.call)

    expect(page).to have_css root_selector, exact_text: 'status text', count: 1
    expect(page).to have_no_css "#{root_selector} > span.status-bubble"
  end

  it_behaves_like 'a component with html options', root_selector

  [:dotted, :outline, :solid].each do |bubble|
    it "renders with the #{bubble} bubble" do
      render_inline(build_component.call(bubble:))

      expect(page).to have_css root_selector, exact_text: 'status text', count: 1
      expect(page).to have_css "#{root_selector} > span.status-bubble.status-bubble-#{bubble}", count: 1
    end
  end
end
