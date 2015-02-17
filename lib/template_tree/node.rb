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
      lines.join("\n")
    end

    def lines
      [name] + indent_children(children.map(&:lines))
    end

    private

    def indent_children(children)
      return [] unless children.length > 0

      children[0..-2].flat_map do |lines|
        indent_lines("├── ", "|   ", lines)
      end + indent_lines("└── ", "    ", children.last)
    end

    def indent_lines(leader, continuation, lines)
      [leader + lines.first.strip] +
        lines.drop(1).map { |line| continuation + line.strip }
    end
  end
end
