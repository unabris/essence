# frozen_string_literal: true

module IconFingerprint
  module_function

  def from_name(name)
    path = Essence::IconComponent.images_directory.join("#{name}.svg")

    raise ArgumentError, "Unknown icon #{name.inspect}" unless path.exist?

    from_node(path.read)
  end

  # Accepts a Capybara node, a Nokogiri node or an HTML string containing an <svg>.
  def from_node(node)
    node = node.native if node.respond_to?(:native)
    node = Capybara.HTML(node).at_css('svg') if node.is_a?(String)

    return if node.nil? || node.name != 'svg'

    # Only the drawing elements are compared, since the root <svg> gets extra attributes when rendered.
    node.css('*').map { |element| [element.name, element.attributes.transform_values(&:value).sort] }
  end

  def find_name(fingerprint)
    Essence::IconComponent::NAME_OPTIONS.find { |name| from_name(name) == fingerprint }
  end
end

# Usage: expect(page.find('svg.notification-icon')).to match_icon('circle_check')
RSpec::Matchers.define :match_icon do |expected_name|
  match do |actual|
    @actual_fingerprint = IconFingerprint.from_node(actual)

    @actual_fingerprint.present? && @actual_fingerprint == IconFingerprint.from_name(expected_name)
  end

  failure_message do
    actual_name = IconFingerprint.find_name(@actual_fingerprint) if @actual_fingerprint
    actual_description = actual_name ? "the #{actual_name.inspect} icon" : 'an unknown SVG'

    "expected the #{expected_name.inspect} icon, but got #{actual_description}"
  end

  failure_message_when_negated do
    "expected an icon other than #{expected_name.inspect}"
  end
end
