# frozen_string_literal: true

# module with functions to help the tree functions
module TreeHelper
  def recur_tree(array, start, finish)
    return nil if start > finish

    mid = (start + finish) / 2
    node = Node.new(array[mid])
    node.left = recur_tree(array, start, mid - 1)
    node.right = recur_tree(array, mid + 1, finish)
    node
  end

  def find_and_insert(node, value)
    case node <=> value
    when -1
      node.right.nil? ? node.right = Node.new(value) : find_and_insert(node.right, value)
    when 1
      node.left.nil? ? node.left = Node.new(value) : find_and_insert(node.left, value)
    else
      raise 'This value exists in the tree already'
    end
  end

  def find_and_delete(parent, node, value)
    raise 'This node cannot be found.' if node.nil?

    case node <=> value
    when -1
      find_and_delete(node, node.right, value)
    when 1
      find_and_delete(node, node.left, value)
    else
      delete_the_node(parent, node)
    end
  end

  def delete_the_node(parent, node)
    if node.right.nil? && node.left.nil?
      replace_in_node(parent, node, nil)
    elsif node.left.nil?
      replace_in_node(parent, node, node.right)
    elsif node.right.nil?
      replace_in_node(parent, node, node.left)
    else
      delete_for_steric_node(node)
    end
  end

  def delete_for_steric_node(node)
    successor = node.right
    successor = successor.left until successor.left.nil?
    succeeded_value = successor.data

    find_and_delete(node, node.right, succeeded_value)
    node.data = succeeded_value
  end

  def replace_in_node(parent, node, value)
    (parent.left <=> node).zero? ? parent.left = value : parent.right = value
  end

  def breadth_first_search(node, results, index, block = nil)
    return if node.nil?

    results.push([]) if index >= results.length
    block_given? ? block.call : results[index].push(node.data)
    breadth_first_search(node.left, results, index + 1, block)
    breadth_first_search(node.right, results, index + 1, block)
  end

  def preorder_helper(node, results)
    return if node.nil?

    results.push(node.data)
    preorder_helper(node.left, results)
    preorder_helper(node.right, results)
  end

  def inorder_helper(node, results)
    return if node.nil?

    inorder_helper(node.left, results)
    results.push(node.data)
    inorder_helper(node.right, results)
  end

  def postorder_helper(node, results)
    return if node.nil?

    postorder_helper(node.left, results)
    postorder_helper(node.right, results)
    results.push(node.data)
  end
end
