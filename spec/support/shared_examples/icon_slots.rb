# frozen_string_literal: true

# The host group must define `name` and `build_component`, a lambda that takes html options and returns the
# component.
RSpec.shared_examples 'a component with icon slots' do |root_selector, icon_class|
  let(:icon) { 'arrow_up_right_from_square' }

  it 'renders the given :left_icon before the name' do
    render_inline(build_component.call) do |component|
      component.with_left_icon icon
    end

    expect(page).to have_css "#{root_selector} > svg.#{icon_class}", count: 1
    expect(page.find("#{root_selector} > svg.#{icon_class}:first-child")).to match_icon(icon)
    expect(page).to have_css "#{root_selector} > span:last-child", exact_text: name, count: 1
  end

  it 'renders the given :right_icon after the name' do
    render_inline(build_component.call) do |component|
      component.with_right_icon icon
    end

    expect(page).to have_css "#{root_selector} > svg.#{icon_class}", count: 1
    expect(page.find("#{root_selector} > svg.#{icon_class}:last-child")).to match_icon(icon)
    expect(page).to have_css "#{root_selector} > span", exact_text: name, count: 1
  end
end
