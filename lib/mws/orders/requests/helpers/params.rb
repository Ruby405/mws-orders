module MWS
  module Orders
    module Request
      module Helper
        class Params < SimpleDelegator
          def initialize(action)
            super({ 'Action' => action })
          end

          def timestamp!
            each do |key, value|
              store(key, value.iso8601) if value.respond_to?(:iso8601)
            end

            self
          end

          def format_structured_lists!
            lists = {}

            each do |key, value|
              if StructuredList.handle?(key)
                lists.update(StructuredList.new(key).build(delete(key)))
              end
            end

            update(lists)
          end

          def camelize_keys!
            keys.each do |key|
              if key.is_a?(Symbol)
                new_key = key.to_s.split('_').map(&:capitalize).join
                store(new_key, delete(key))
              end
            end

            self
          end
        end
      end
    end
  end
end
