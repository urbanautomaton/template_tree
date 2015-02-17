require 'spec_helper'
require 'template_tree/tree'

RSpec.describe TemplateTree::Tree do
  subject { described_class.new }

  it "records a series of nodes" do
    subject.enter("a")
    subject.enter("b")
    subject.exit
    subject.enter("c")

    expected = [".", [["a", [["b", []], ["c", []]]]]]

    expect(subject.to_a).to eq expected
  end

  it "raises an error if the root node is exited" do
    expect {
      subject.enter("a")
      subject.exit
      subject.exit
    }.to raise_error TemplateTree::ExitRootError
  end

end
