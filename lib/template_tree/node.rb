require 'template_tree/formatters/ascii'

module TemplateTree
  class Node
    attr_reader :name, :parent, :children

    def initialize(name, parent)
      @name, @parent = name, parent
      @children = []
    end

    def to_a
      [name, children.map(&:to_a)]
    end

    def to_s
      Formatters::Ascii.new.format(self)
    end

  end
end
