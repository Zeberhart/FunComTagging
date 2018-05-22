module CommentsHelper
  def current_comment
    return Comment.find(@user.current_comment_id) unless @user.current_comment_id > Comment.count
    return Comment.find(@user.current_comment_id-1)
  end

  def prev_comment
    if params[:id].to_i > 1
      return Comment.find(params[:id].to_i - 1)
    else
      return Comment.find(params[:id].to_i)
    end
  end

  def next_comment
    if params[:id].to_i < Comment.count
      return Comment.find(params[:id].to_i+ 1)
    else
      return Comment.find(params[:id].to_i)
    end
  end
end
