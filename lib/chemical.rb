require "chemical/version"

module Chemical
  def self.new(styles = {})
    Composition.new(styles)
  end

  class Composition
    def initialize(styles)
      @styles = styles
    end

    def to_s
      @styles.values.compact.join(' ')
    end

    def call(styles)
      self.class.new(@styles.merge(styles))
    end
  end

  private_constant :Composition
end
