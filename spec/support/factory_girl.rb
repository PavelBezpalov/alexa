RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    ActiveSupport::Notifications.subscribe('factory_girl.run_factory') do |_name, start, finish, _id, payload|
      execution_time_in_seconds = finish - start

      if execution_time_in_seconds >= 0.5
        $stderr.puts "Slow factory: #{payload[:name]} using strategy #{payload[:strategy]}"
      end
    end
  end
end
