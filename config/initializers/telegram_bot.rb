Rails.application.config.after_initialize do
  TelegramBotJob.set(wait: 5.seconds).perform_later
end
