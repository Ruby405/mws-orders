module MWS
  module Orders
    module Parser
      class Orders < Collection
        def each(&blk)
          order_nodes.each { |node| yield Order.new(node) }
        end

        private

        def order_nodes
          xpath('Order')
        end
      end
    end
  end
end