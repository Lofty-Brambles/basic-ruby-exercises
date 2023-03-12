# frozen_string_literal: true

require_relative 'node'

# main linked list
class LinkedList
  def initialize
    @list = nil
  end

  def append(value)
    tail.next_node = Node.new(value)
  rescue RuntimeError
    @list = Node.new(value)
  end

  def prepend(value)
    @list = Node.new(value, @list)
  end

  def size
    raise 'The list is empty' if @list.nil?

    seek_size(@list, 0)
  end

  def head
    @list
  end

  def tail
    seek_tail(@list)
  end

  def at(index)
    seek_index(@list, index, 0).value
  end

  def pop
    raise 'The list is empty' if @list.nil?

    remove(@list)
  end

  def contains?(value)
    seek_value(@list, 0, value)
    true
  rescue StandardError
    false
  end

  def find(value)
    seek_value(@list, 0, value)
  end

  def to_s
    print_list(@list, '')
  end

  private

  def seek_size(node, count)
    node.nil? ? count : seek_size(node.next_node, count + 1)
  end

  def seek_tail(node)
    raise 'The list is empty' if node.nil?

    node.next_node.nil? ? node : seek_tail(node.next_node)
  end

  def seek_index(node, index, count)
    raise 'The index is out of bounds' if node.nil?

    index == count ? node : seek_index(node.next_node, index, count + 1)
  end

  # rubocop:disable Metrics/MethodLength

  def remove(node)
    if node.next_node.nil?
      store = node
      @list = nil
      store
    elsif node.next_node.next_node.nil?
      store = node.next_node
      node.next_node = nil
      store
    else
      remove(node.next_node)
    end
  end

  # rubocop:enable Metrics/MethodLength

  def seek_value(node, index, value)
    raise 'The value does not exist in the list' if node.nil?

    value == node.value ? index : seek_value(node.next_node, index + 1, value)
  end

  def print_list(node, string)
    until node.nil?
      string += "( #{node.value} ) -> "
      node = node.next_node
    end
    "#{string}nil"
  end
end
