Capybara.default_max_wait_time = 2

Capybara.add_selector(:test_id) do
  css { |value| "[data-test-id='#{value}']" }
end
