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
        @move_tree = build_move_tree
        @considered_positions = [start_pos]
    end

    def new_move_positions(pos)
        new_moves = KnightPathFinder.valid_moves(pos).reject do |new_pos| 
            considered_positions.include?(new_pos)
        end
        considered_positions.concat(new_moves)
        new_moves
    end

    private

    attr_reader :considered_positions
end