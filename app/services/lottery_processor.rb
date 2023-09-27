# frozen_string_literal: true

require 'csv'

class LotteryProcessor
  def self.process_and_save_csv(csv_text, winning_number)
    winners = process_csv(csv_text, winning_number)
    csv_path = save_results_to_csv(winners, winning_number)

    { winners: winners, csv_path: csv_path }
  end

  def self.process_csv(csv_text, winning_number)
    participants_data = CSV.parse(csv_text)

    winnings = calculate_winnings(participants_data, winning_number)

    winnings.select { |_key, value| value.positive? }.sort_by { |key, _value| key }
  end

  def self.calculate_winnings(participants_data, winning_number)
    winnings = Hash.new(0)

    participants_data.each do |row|
      last_name, first_name, country, ticket_number = row
      lcs = LcsCalculator.calculate_lcs(ticket_number, winning_number)
      credits = lcs.length
      winnings["#{last_name},#{first_name},#{country}"] += credits
    end

    winnings
  end

  def self.save_results_to_csv(winners, winning_number)
    file_path = lottery_results_csv_path(winning_number)

    CSV.open(file_path, 'wb') do |csv|
      winners.each do |winner|
        csv << winner.map(&:to_s)
      end
    end

    "Results saved to #{file_path}"
  end

  def self.lottery_results_csv_path(winning_number)
    Rails.root.join('tmp', "lottery_results_#{winning_number}.csv")
  end
end
