require_relative 'molecular/version'

module Molecular
  def self.compound(atoms)
    Compound.new(atoms)
  end

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
