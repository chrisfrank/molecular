require_relative 'spec_helper'
require 'erb'
require 'benchmark/ips'

Benchmark.ips do |bm|
  bm.report('Three identical objects') do
    %(
      <button class="#{UI::Button}">Click Here</button>
      <button class="#{UI::Button}">No, here</button>
      <button class="#{UI::Button}">or here</button>
    )
  end

  bm.report('Three tweaks') do
    %(
      <button class="#{UI::Button.(bg: 'bg-red')}">Click Here</button>
      <button class="#{UI::Button.(bg: 'bg-gold')}">No, here</button>
      <button class="#{UI::Button.(color: 'black')}">or here</button>
    )
  end

  bm.report('raw strings') do
    %(
      <button class="white bg-red br3">Click Here</button>
      <button class="white bg-gold br3">No, here</button>
      <button class="black bg-blue br3}">or here</button>
    )
  end
end
