require 'spec_helper'
require 'template_tree/node'
require 'template_tree/formatters/ascii'

RSpec.describe TemplateTree::Formatters::Ascii do
  let(:tree) do
    TemplateTree::Node.from_a(["a", [["b", [["c", []]]], ["d", []]]])
  end

  it "prints a natty tree" do
    expected = <<-EOS
a
├── b
|   └── c
└── d
EOS

    expect(subject.format(tree)).to eq expected.strip
  end
end
