require 'template_tree/errors'
require 'template_tree/formatters/ascii'

module TemplateTree
  class Node
    attr_accessor :name, :parent, :children

    def initialize(name, parent)
      @name, @parent = name, parent
      @children = []
    end

    def to_a
      [name, children.map(&:to_a)]
    end

    def to_s(formatter: Formatters::Ascii)
      formatter.format(self)
    end

    def self.from_a(ary, parent=nil)
      unless ary.is_a?(Enumerable)
        raise InvalidTreeError, "Input is not an Enumerable"
      end
      unless ary.length == 2
        raise InvalidTreeError, "Array must have exactly two elements"
      end
      unless ary.last.is_a?(Enumerable)
        raise InvalidTreeError, "Child element must be an Enumerable"
      end

      name, children_ary = ary

      new(name, parent).tap do |node|
        children = children_ary.map{|c| from_a(c, node)}
        node.children = children
      end
    end

    def ==(other)
      name == other.name && children == other.children
    end

    def eql?(other)
      self == other
    end

  end
end
