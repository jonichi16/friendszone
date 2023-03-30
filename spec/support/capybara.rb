Capybara.add_selector(:test_id) do
  css { |value| "[data-test-id='#{value}']" }
end
