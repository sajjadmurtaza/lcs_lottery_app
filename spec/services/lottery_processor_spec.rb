# frozen_string_literal: true

# spec/services/lottery_processor_spec.rb

require 'rails_helper'

RSpec.describe LotteryProcessor do
  describe '.process_and_save_csv' do
    it 'returns a hash with winners and csv_path' do
      csv_text = "Last,First,Country,Ticket\nDoe,John,USA,123456\nSmith,Emma,Canada,789012"
      winning_number = '456789'

      result = LotteryProcessor.process_and_save_csv(csv_text, winning_number)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:winners)
      expect(result).to have_key(:csv_path)
    end
  end

  describe '.process_csv' do
    it 'returns processed CSV data' do
      csv_text = "Last,First,Country,Ticket\nDoe,John,USA,123456\nSmith,Emma,Canada,789012"
      winning_number = '456789'

      processed_data = LotteryProcessor.process_csv(csv_text, winning_number)

      expect(processed_data).to be_an(Array)
      expect(processed_data).to include(['Doe,John,USA', 3])
      expect(processed_data).to include(['Smith,Emma,Canada', 3])
    end
  end

  describe '.calculate_winnings' do
    it 'calculates winnings correctly' do
      participants_data = [%w[Doe John USA 123456], %w[Smith Emma Canada 789012]]
      winning_number = '456789'

      winnings = LotteryProcessor.calculate_winnings(participants_data, winning_number)

      expect(winnings).to be_a(Hash)
      expect(winnings).to include('Doe,John,USA' => 3)
      expect(winnings).to include('Smith,Emma,Canada' => 3)
    end
  end

  describe '.lottery_results_csv_path' do
    it 'returns the correct file path' do
      winning_number = '456789'

      file_path = LotteryProcessor.lottery_results_csv_path(winning_number)

      expect(file_path.to_s).to end_with("lottery_results_#{winning_number}.csv")
    end
  end
end
