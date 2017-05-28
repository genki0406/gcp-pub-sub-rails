class SampleJob < ApplicationJob
  queue_as :default
  def perform(num)
    p '==================='
    p "#{num} sample job executed!"
    p '==================='
  end
end
