require 'spec_helper'
require 'template_tree/tree'

RSpec.describe TemplateTree::Tree do
  subject { described_class.new }

  it "records a series of nodes" do
    subject.enter("a")
    subject.enter("b")
    subject.exit
    subject.enter("c")

    expected = {
      "root" => [
        {
          "a" => [
            { "b" => [] },
            { "c" => [] }
          ]
        }
      ]
    }

    expect(subject.to_h).to eq expected
  end

  it "prints a natty tree" do
    subject.enter("a")
    subject.enter("b")
    subject.enter("c")
    subject.exit
    subject.exit
    subject.enter("d")
    subject.exit
    subject.exit
    subject.enter("e")

    expected = <<-EOS
root
├── a
|   ├── b
|   |   └── c
|   └── d
└── e
EOS

    expect(subject.to_s).to eq expected.strip
  end

  it "raises an error if the root node is exited" do
    expect {
      subject.enter("a")
      subject.exit
      subject.exit
    }.to raise_error TemplateTree::ExitRootError
  end

end
