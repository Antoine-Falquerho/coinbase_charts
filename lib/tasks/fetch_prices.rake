desc "I am short, but comprehensive description for my cool task"
task fetch_prices: :environment do
  Bitcoin.fetch_prices
end