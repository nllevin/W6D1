require_relative "./PolyTreeNode/lib/00_tree_node.rb"

class KnightPathFinder
    def self.valid_moves(pos)
        valids = []
        deltas = [[2, 1], [2, -1],
            [-2, 1], [-2, -1],
            [1, 2], [1, -2],
            [-1, 2], [-1, -2]]

        row, col = pos
        deltas.each do |delta_row, delta_col|
            new_pos = [row + delta_row, col + delta_col]
            valids << new_pos if new_pos.all? { |coord| coord.between?(0, 7) }
        end

        valids
    end

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        build_move_tree
    end

    def new_move_positions(pos)
        new_moves = KnightPathFinder.valid_moves(pos).reject do |new_pos| 
            considered_positions.include?(new_pos)
        end
        considered_positions.concat(new_moves)
        new_moves
    end

    def build_move_tree
        queue = [root_node]
        until queue.empty?
            current_node = queue.shift
            new_move_positions(current_node.value).each do |next_pos|
                next_node = PolyTreeNode.new(next_pos)
                current_node.add_child(next_node)
                queue << next_node
            end
        end
    end

    def find_path(end_pos)
        trace_path_back(root_node.dfs(end_pos))
    end

    def trace_path_back(end_node)
        path = []
        current_node = end_node
        until current_node.nil?
            path << current_node.value
            current_node = current_node.parent
        end
        path.reverse
    end

    private

    attr_reader :considered_positions, :root_node
end