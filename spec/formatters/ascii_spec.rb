require 'spec_helper'
require 'template_tree/tree'
require 'template_tree/formatters/ascii'

RSpec.describe TemplateTree::Formatters::Ascii do
  let(:tree) do
    tree = TemplateTree::Tree.new
    tree.enter("a")
    tree.enter("b")
    tree.exit
    tree.exit
    tree.enter("c")
    tree
  end
  subject { described_class.new }

  it "prints a natty tree" do
    expected = <<-EOS
.
├── a
|   └── b
└── c
EOS

    expect(subject.format(tree)).to eq expected.strip
  end
end
