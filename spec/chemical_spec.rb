require 'erb'
require 'spec_helper'

module UI
  Button = Chemical.new(
    color: 'white',
    bg: 'bg-blue',
    base: 'br3',
    falsy: nil
  )
end

RSpec.describe Chemical do
  it "has a version number" do
    expect(Chemical::VERSION).not_to be nil
  end

  it 'renders the default classes' do
    ERB.new(%q{
      <button class="<%= UI::Button %>">
        Click Me
      </button>
    }).result(binding).tap do |res|
      expect(res).to include "bg-blue"
    end
  end

  it 'replaces the correct classes when asked' do
    ERB.new(%q{
      <button class="<%= UI::Button.(bg: 'bg-red') %>">
        Click Me
      </button>
    }).result(binding).tap do |res|
      expect(res).not_to include "bg-blue"
      expect(res).to include "bg-red"
    end
  end
end
