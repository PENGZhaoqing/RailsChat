class ChatsController < ApplicationController
  include SessionsHelper
  include ChatsHelper
  respond_to :js, :html
  before_action :logged_in
  before_action :set_chat, except: [:index, :new, :create]
  before_action :correct_user, only: :show

  def index
    @friends=current_user.friends+current_user.inverse_friends
  end

  def add_user
    params[:users].each do |id|
      @chat.users<<User.find_by_id(id)
    end
    redirect_to chat_path(@chat), flash: {:info => "用户已成功拉入群聊"}
  end

  def delete_user
    user=User.find_by_id(params[:user_id])
    @chat.users.delete(user)
    redirect_to chat_path(@chat), flash: {:warning => "#{user.name}已成功退出群聊"}
  end

  def create
    user=User.find_by_id(params[:users])

    current_user.chats.each do |chat|
      if (chat.users-[user, current_user]).blank?
        redirect_to chat_path(chat) and return
      end
    end

    @chat = Chat.new
    @chat.users<<user
    @chat.users<<current_user
    @chat.admin_id=current_user.id
    @chat.name="#{user.name}-#{current_user.name}"

    if @chat.save
      redirect_to chat_path(@chat)
    else
      flash[:warning] = "错误,请重试"
      render chats_path, flash: flash
    end
  end

  def update
    if @chat.update_attributes(chat_params)
      flash= {success: "修改成功"}
    else
      flash= {danger: "修改失败，请重试"}
    end
    redirect_to chat_path(@chat), flash: flash
  end

  def trans_auth
    @chat.update_attribute(:admin_id, params[:admin_id])
    redirect_to chat_path(@chat), flash: {success: '移交成功！'}
  end

  def destroy
    @chat.destroy
    redirect_to chats_path, flash: {:danger => '聊天已删除'}
  end

  def show
    @new_message = Message.new
    @users_in_chat= @chat.users-[current_user]
    @friends=current_user.friends+current_user.inverse_friends
    @friends_out_chat=@friends-@chat.users
  end

  private

  def chat_params
    params.require(:chat).permit(:name, :description)
  end

  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def set_chat
    @chat=Chat.find_by_id(params[:id])
    if @chat.nil?
      redirect_to chats_path, flash: {:warning => "没有找到此次聊天的信息"}
    end
  end

  def correct_user
    if @chat.users.include?(current_user)
    else
      redirect_to chats_path, flash: {warning: '您没有权限无法进入此聊天室'}
    end
  end

end