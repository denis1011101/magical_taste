# TODO: разобраться почему не запускаться с командой foreman start

class TelegramBotJob < ApplicationJob
  queue_as :default

  def perform(*args)
    require 'telegram/bot'
    require 'net/http'
    require 'uri'

    token = ENV['TELEGRAM_BOT_TOKEN']

    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        case message
        when Telegram::Bot::Types::CallbackQuery
          if message.data == 'random_mix'
            uri = URI('http://0.0.0.0:5100/api/v1/mixes/random_mix')
            response = Net::HTTP.get(uri)
            bot.api.send_message(chat_id: message.from.id, text: "Ваш случайный микс: #{response}")
          end
        when Telegram::Bot::Types::Message
          if message.text == '/start'
            kb = [
              [Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Случайный микс', callback_data: 'random_mix')]
            ]
            markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
            bot.api.send_message(
              chat_id: message.chat.id,
              text: "Привет, #{message.from.first_name}. Выбери действие:",
              reply_markup: markup
            )
          else
            query = URI.encode_www_form_component(message.text)
            uri = URI("http://0.0.0.0:5100/api/v1/mixes/selection_of_taste?query=#{query}")
            response = Net::HTTP.get(uri)
            bot.api.send_message(chat_id: message.from.id, text: "Результаты по вашему запросу: #{response}")
          end
        end
      end
    end
  end
end
