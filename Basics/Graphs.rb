
# List / Queue

def depth_first_search(adj_matrix, source_index, end_index)
  node_stack = [source_index]

  loop do
    curr_node = node_stack.pop
    return false if curr_node == nil
    return true if curr_node == end_index

    children = (0..adj_matrix.length-1).to_a.select do |i| 
      adj_matrix[curr_node][i] == 1
    end

    node_stack = node_stack + children
  end
end
# depth_first_search(adj_matrix, source_index, end_index)

adj_matrix = [
  [0, 0, 1, 0, 1, 0],
  [0, 0, 1, 0, 0, 1],
  [0, 0, 0, 1, 0, 0],
  [0, 0, 0, 0, 1, 1],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0]
]

p depth_first_search(adj_matrix, 0, 4)



def breadth_first_search(adj_matrix, source_index, end_index)
  node_queue = [source_index]

  loop do
    curr_node = node_queue.pop

    return false if curr_node == nil
    return true if curr_node == end_index

    children = (0..adj_matrix.length-1).to_a.select do |i| 
      adj_matrix[curr_node][i] == 1
    end

    node_queue = children + node_queue
  end
end
