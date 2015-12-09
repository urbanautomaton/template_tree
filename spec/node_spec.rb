require 'spec_helper'
require 'template_tree/node'

RSpec.describe TemplateTree::Node do
  subject { described_class.new("a", nil) }

  describe ".from_a" do
    it "takes the name from the first element" do
      input = ["a", []]

      expect(TemplateTree::Node.from_a(input)).to eq(
        TemplateTree::Node.new("a", nil)
      )
    end

    it "takes the children from the second element" do
      input = ["a", [["b", []]]]

      tree = TemplateTree::Node.from_a(input)

      expect(tree.children).to eq(
        [TemplateTree::Node.new("b", tree)]
      )
    end

    it "raises an ArgumentError if the input is not an Enumerable" do
      expect {
        TemplateTree::Node.from_a("wat")
      }.to raise_error TemplateTree::InvalidTreeError
    end

    it "raises an InvalidTreeError if there are insufficient elements" do
      input = ["a", [], []]

      expect {
        TemplateTree::Node.from_a(input)
      }.to raise_error TemplateTree::InvalidTreeError
    end

    it "raises an InvalidTreeError unless the second element is an Enumerable" do
      input = ["a", "b"]

      expect {
        TemplateTree::Node.from_a(input)
      }.to raise_error TemplateTree::InvalidTreeError
    end

    it "raises an InvalidTreeError if child elements are invalid" do
      input = ["a", ["b"]]

      expect {
        TemplateTree::Node.from_a(input)
      }.to raise_error TemplateTree::InvalidTreeError
    end
  end

  describe "#==" do
    it "is equal if the name and children are equal" do
      one = TemplateTree::Node.from_a(["a", [["b", []], ["c", []]]])
      two = TemplateTree::Node.from_a(["a", [["b", []], ["c", []]]])

      expect(one).to eq two
    end

    it "is not equal if the name differs" do
      one = TemplateTree::Node.from_a(["a", [["b", []]]])
      two = TemplateTree::Node.from_a(["z", [["b", []]]])

      expect(one).to_not eq two
    end

    it "is not equal if the children differ" do
      one = TemplateTree::Node.from_a(["a", [["b", []]]])
      two = TemplateTree::Node.from_a(["a", [["p", []]]])

      expect(one).to_not eq two
    end
  end

  describe "#ordered_leaves" do
    it "returns just the ordered leaf nodes" do
      tree = TemplateTree::Node.from_a(
        [
          "a",
          [
            ["b", []],
            ["c", [["d", []]]]
          ]
        ]
      )

      expect(tree.ordered_leaves).to eq ["b", "d"]
    end
  end

  describe "#filter_leaves" do
    it "returns the subset of the tree leading to the leaves" do
      tree = TemplateTree::Node.from_a(
        [
          "a",
          [
            ["b", []],
            ["c", [["d", []]]],
            ["e", []]
          ]
        ]
      )

      expected = TemplateTree::Node.from_a(
        ["a", [["c", [["d", []]]], ["e", []]]]
      )

      expect(tree.filter(["d", "e"])).to eq expected
    end
  end

end
