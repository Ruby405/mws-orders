module MWS
  module Orders
    module Parser
      class ServiceStatus < Model
        value :status do
          text_at_xpath('Status')
        end

        value :timestamp do
          time_at_xpath('Timestamp')
        end

        value :message_id do
          text_at_xpath('MessageId')
        end

        value :messages do
          xpath('Messages/Message').map { |node| ServiceStatusMessage.new(node) }
        end

        def ok?
          status == 'GREEN'
        end

        def inspect
          status
        end
        alias :to_s :inspect
      end
    end
  end
end
