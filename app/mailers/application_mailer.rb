# frozen_string_literal: true

# Default Mailer Until we Implement Mailing
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
