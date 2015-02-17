module TemplateTree
  module Formatters
    class Ascii

      def format(node)
        lines(node).join("\n")
      end

      def lines(node)
        [node.name] + indent_children(node.children.map {|c| lines(c)})
      end

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
end
