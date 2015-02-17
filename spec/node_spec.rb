require 'spec_helper'
require 'template_tree/node'

RSpec.describe TemplateTree::Node do
  subject { described_class.new("a", nil) }

  it "is equal if the name and children are equal" do
    one = TemplateTree::Node.from_a(["a", [["b", []], ["c", []]]])
    two = TemplateTree::Node.from_a(["a", [["b", []], ["c", []]]])


    expect(one).to eq two
  end

end
