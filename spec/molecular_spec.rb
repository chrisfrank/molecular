require 'erb'
require 'spec_helper'

RSpec.describe Molecular do
  it 'has a version number' do
    expect(Molecular::VERSION).not_to be nil
  end

  it 'renders the default classes' do
    ERB.new('
      <button class="<%= UI::Button %>">
        Click Me
      </button>
    ').result(binding).tap do |res|
      expect(res).to include 'bg-blue'
    end
  end

  it 'replaces the correct classes when asked' do
    ERB.new(%q{
      <button class="<%= UI::Button.(bg: 'bg-red') %>">
        Click Me
      </button>
    }).result(binding).tap do |res|
      expect(res).not_to include 'bg-blue'
      expect(res).to include 'bg-red'
    end
  end

  it 'returns a new object on self.call' do
    first = UI::Button
    second = UI::Button.call(bg: 'bg-blue')
    third = UI::Button

    expect(first).to be(third)
    expect(first).not_to be(second)
  end
end
