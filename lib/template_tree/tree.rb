require 'template_tree/errors'
require 'template_tree/node'

module TemplateTree
  class Tree < Node

    def initialize
      @name         = "."
      @children     = []
      @current_node = self
    end

    def enter(name)
      node = Node.new(name, @current_node)
      @current_node.children << node
      @current_node = node
    end

    def exit
      if @current_node == self
        raise(ExitRootError, "Attempted to exit the root node")
      end

      @current_node = @current_node.parent
    end

  end
end
