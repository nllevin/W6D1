class PolyTreeNode
    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(new_parent)
        parent.children.delete(self) unless parent.nil?
        @parent = new_parent
        new_parent.children << self unless new_parent.nil?
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "That is not my child" unless children.include?(child_node)
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if value == target_value
        children.each do |child|
            search_result = child.dfs(target_value)
            return search_result unless search_result.nil?
        end
        nil
    end

    def bfs(target_value)

    end
end