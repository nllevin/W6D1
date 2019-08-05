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
end