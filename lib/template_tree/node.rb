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

    def to_s
      Formatters::Ascii.new.format(self)
    end

    def self.from_a(ary, parent=nil)
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
