require 'template_tree/errors'
require 'template_tree/node'

module TemplateTree
  class Tree

    def initialize(root_node="root")
      @store = {}
      @current_node = @root_node = Node.new(root_node, nil)
    end

    def enter(name)
      node = Node.new(name, @current_node)
      @current_node.children << node
      @current_node = node
    end

    def exit
      raise(ExitRootError, "Attempted to exit the root node") unless @current_node.parent

      @current_node = @current_node.parent
    end

    def to_h
      @root_node.to_h
    end

    def to_s
      @root_node.lines.join("\n")
    end

  end
end
