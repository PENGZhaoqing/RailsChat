class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat

  sync :all
  sync_scope :by_chat, ->(chat) { where(chat_id: chat.id) }
end
