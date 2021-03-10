class Hiring::SendEmailController < ApplicationController
  def destory
    File.delete("storage/send_later/#{params['id']}") if File.exist?("storage/send_later/#{params['id']}")
    flash[:success] = 'Successfully delete this job: ' + params['id']
    redirect_to admin_queue_url
  end

  def create
      if params['id'] != 'all'
        line = File.readlines("storage/send_later/#{params['id']}")
        EmailMailer.template(line[1].gsub(/\s+/, ''), line[2].gsub(/\s+/, ' '), line[3].gsub(/\s+/, ' '), line[4].gsub(/\s+/, ' ')).deliver_now
        File.delete("storage/send_later/#{params['id']}") if File.exist?("storage/send_later/#{params['id']}")
        flash[:success] = 'Successfully send email for job: ' + params['id']
        redirect_to admin_queue_url
      else
        file = Dir.foreach('storage/send_later').select { |x| File.file?("#{"storage/send_later"}/#{x}") }
        file.delete('.keep')
        file.each do |job|
          line = File.readlines("storage/send_later/#{job}")
          EmailMailer.template(line[1].gsub(/\s+/, ''), line[2].gsub(/\s+/, ' '), line[3].gsub(/\s+/, ' '), line[4].gsub(/\s+/, ' ')).deliver_now
          File.delete("storage/send_later/#{job}") if File.exist?("storage/send_later/#{job}")
        end
        flash[:success] = 'Successfully send email all email'
        redirect_to admin_hiring_url
      end
    end
end