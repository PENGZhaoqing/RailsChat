module ChatsHelper

  def contact_active
    'active' if params[:action]=='index'
  end

  def chat_active
    'active' if params[:action]=='show'
  end

end
