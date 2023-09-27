# frozen_string_literal: true

require 'csv'
# app/controllers/lottery_controller.rb
class LotteryController < ApplicationController
  before_action :lottery_files, only: :index

  def index; end

  def upload_csv
    winning_number = params[:winning_number]
    uploaded_file = params[:csv_file]

    return unless uploaded_file

    csv_text = uploaded_file.read
    result = LotteryProcessor.process_and_save_csv(csv_text, winning_number)

    if result
      flash[:notice] = result[:csv_path]
      @winners = result[:winners]
    end

    render :index
  end

  def download_csv
    file_path = Rails.root.join('tmp', params[:filename])

    if File.exist?(file_path)
      send_file file_path, disposition: 'attachment'
    else
      flash[:alert] = 'File not found.'
      redirect_to root_path
    end
  end

  private

  def lottery_files
    @lottery_files ||= Dir[Rails.root.join('tmp', 'lottery_results_*.csv')]
  end
end
