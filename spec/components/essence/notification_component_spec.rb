# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Essence::NotificationComponent, type: :component do
  {
    success: { css_class: 'notification-success', icon: 'circle_check' },
    notice: { css_class: 'notification-notice', icon: 'circle_check' },
    info: { css_class: 'notification-info', icon: 'circle_info' },
    warning: { css_class: 'notification-warning', icon: 'circle_exclamation' },
    danger: { css_class: 'notification-danger', icon: 'circle_xmark' },
    alert: { css_class: 'notification-danger', icon: 'circle_xmark' }
  }.each do |variant, expected|
    context "with `variant: :#{variant}`" do
      it_behaves_like 'notification component', variant, **expected
    end
  end

  it 'uses the info variant by default' do
    render_inline(described_class.new.with_content('Notification text'))

    expect(page).to have_css 'body > div.notification.notification-info', count: 1
    expect(page.find('svg.notification-icon')).to match_icon('circle_info')
  end

  it 'raises an error with an invalid :variant' do
    expect { described_class.new(variant: :invalid) }
      .to raise_error(Essence::FetchOrFallbackHelper::InvalidValueError)
  end
end
