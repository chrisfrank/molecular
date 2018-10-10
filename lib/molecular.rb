require_relative 'molecular/version'

# Build reusable, tweakable UI elements out of atomic-CSS classes
module Molecular
  # @example
  #   Button = Compound.new(bg: 'bg-blue', color: 'white')
  #   <button class="<%= Button %>">A blue button</button>
  #   <button class="<%= Button.(bg: 'bg-red') %>">A red button</button>
  #
  # @param [Hash] atoms:
  #  - values are the CSS class names that get chained
  #  - keys define the API you'll use to apply alternate classes
  def self.compound(atoms)
    Compound.new(atoms)
  end

  # Calling Molecular.compound returns an instance of Molecular::Compound
  class Compound
    def initialize(atoms)
      @atoms = atoms
    end

    def to_s
      @atoms.values.compact.join(' ')
    end

    def call(atoms)
      self.class.new(@atoms.merge(atoms))
    end
  end
end
