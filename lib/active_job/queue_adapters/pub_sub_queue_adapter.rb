require 'json'
require 'google/cloud/pubsub'

module ActiveJob
  module QueueAdapters
    class PubSubQueueAdapter

      def enqueue(job)
        Rails.logger.info "[PubSubQueueAdapter] enqueue job #{job.inspect}"

        topic = PubSubQueueAdapter.pubsub.topic(job.queue_name, autocreate: true)

        topic.publish(job.class.name, arg: job.arguments)
      end

      class << self
        def pubsub
          @pubsub ||= begin
            project_id = Rails.application.config.x.settings['project_id']
            Google::Cloud::Pubsub.new(
              project: project_id,
              keyfile: "#{Rails.root.join('config')}/#{Rails.application.config.x.settings['auth_file']}"
            )
          end
        end

        def run_worker!(queue_name = 'default')
          p 'Running worker'

          topic        = pubsub.topic(queue_name, autocreate: true)
          subscription = topic.subscription("#{queue_name}_task")

          topic.subscribe("#{queue_name}_task") if subscription.blank?

          subscription.listen(autoack: true) do |message|
            message.data.constantize.send(:perform_now, *JSON.parse(message.attributes['arg']))
          end
        end
      end
    end
  end
end
