# frozen_string_literal: true

# lib/tasks/lottery.rake

namespace :lottery do
  desc 'Generate winners from a CSV file'
  task :generate_winners, %i[csv_file winning_number] => :environment do |_, args|
    csv_file_path = args[:csv_file]
    winning_number = args[:winning_number]

    if csv_file_path.present? && File.exist?(csv_file_path)
      csv_text = File.read(csv_file_path)
      sorted_winnings = LotteryProcessor.process_csv(csv_text, winning_number)

      sorted_winnings.each do |winner, credits|
        puts "#{winner},#{credits}"
      end
    else
      puts 'CSV file not found.'
    end
  end
end
