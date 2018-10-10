require_relative 'spec_helper'
require 'erb'
require 'benchmark/ips'

def ui_button
  Molecular.compound(
    color: 'white',
    bg: 'bg-blue',
    base: 'br3',
    falsy: nil
  )
end

Benchmark.ips do |bm|
  bm.report('Three identical objects') do
    ERB.new(
      %(
        <button class="#{UI::Button}">Click Here</button>
        <button class="#{UI::Button}">No, here</button>
        <button class="#{UI::Button}">or here</button>
      )
    ).result(binding)
  end

  bm.report('Three tweaks') do
    ERB.new(
      %(
        <button class="#{UI::Button.(bg: 'bg-red')}">Click Here</button>
        <button class="#{UI::Button.(bg: 'bg-gold')}">No, here</button>
        <button class="#{UI::Button.(color: 'black')}">or here</button>
      )
    ).result(binding)
  end

  bm.report('raw strings') do
    ERB.new(
      %(
        <button class="white bg-red br3">Click Here</button>
        <button class="white bg-gold br3">No, here</button>
        <button class="black bg-blue br3">or here</button>
      )
    ).result(binding)
  end

  bm.report('Three new objects') do
    ERB.new(
      %(
        <button class="#{ui_button}">Click Here</button>
        <button class="#{ui_button}">No, here</button>
        <button class="#{ui_button}">or here</button>
      )
    ).result(binding)
  end

  bm.report('Three new objects with tweaks') do
    ERB.new(
      %(
        <button class="#{ui_button.(color: 'black')}">Click Here</button>
        <button class="#{ui_button.(bg: 'bg-red', color: 'blue')}">No, here</button>
        <button class="#{ui_button.(bg: 'bg-gold')}">or here</button>
      )
    ).result(binding)
  end
end
