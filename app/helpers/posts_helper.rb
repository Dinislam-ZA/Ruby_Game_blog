# frozen_string_literal: true

module PostsHelper
  def current_userf
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end
end
