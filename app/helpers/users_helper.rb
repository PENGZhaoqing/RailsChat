module UsersHelper
  def available_user
    return  @users- [User.find_by_name("无作者")]
  end
end
