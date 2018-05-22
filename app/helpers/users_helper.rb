module UsersHelper
  def current_user
    return User.find_by(id: session[:user_id])
  end

  def translate_index(comment_index)
    items = [*1..Comment.count]
    items.shuffle!(random: Random.new(session[:user_id]))
    return items[comment_index.to_i - 1]
  end
end
