require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  test "has root" do
    nodes = Node.roots
    assert nodes.count == 2
  end

  test "has children" do
    root = Node.root
    assert root.descendants.count == 4
  end

  test "building from scratch simple" do
    Node.delete_all

    root = Node.new(name: 'Output', node_type: 'output')
    action = Node.new(name: 'Action', node_type: 'action')
    action2 = Node.new(name: 'Action2', node_type: 'action')
    root.children << action
    root.children << action2
    root.save

    assert root.descendants.count == 2
  end

  test "building from scratch" do
    Node.delete_all

    root = Node.create(name: 'Output', node_type: 'output')
    action = Node.create(name: 'Action', node_type: 'action')
    action.move_to_child_of(root)
    action2 = Node.create(name: 'Action2', node_type: 'action')
    action2.move_to_child_of(root)
    action3 = Node.create(name: 'Action3', node_type: 'action')
    action3.move_to_child_of(root)

    input = Node.create(name: 'Input', node_type: 'input')
    input.move_to_child_of(action3)

    assert root.descendants.count == 4
    assert action3.descendants.count == 1

    action21 = Node.create(name: 'Action21', node_type: 'action')
    input2 = Node.create(name: 'Input2', node_type: 'input')
    input2.move_to_child_of(action21)
    action21.move_to_child_of(action2)

    root.reload
    assert root.descendants.count == 6
    assert action2.descendants.count == 2
  end
end
