class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :tag]
  before_action :set_user, only: [:show, :tag]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    if(params[:id].to_i > @user.current_comment_id)
      redirect_to Comment.find(@user.current_comment_id)
    end
    @tag = Tag.where(user_id: session[:user_id], comment_id: @comment.id).first
  end

   # GET /comments/new
  def new
    @comment = Comment.new
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def tag
    #Enforce length, etc.
    # params[:secondary_labels].each do |label|
    #   if label == params[:primary_label]
    #     return redirect_to @project, alert: "The primary label may not also be chosen as a secondary label."
    #   end
    # end unless params[:secondary_labels].nil?
    
    #Create or update tag
    @tag = Tag.where(user_id: session[:user_id], comment_id: @comment.id).first
    if @tag.nil?
      @tag = Tag.new do |t|
        t.user_id = session[:user_id]
        t.comment_id = @comment.id
        t.body = params[:tag]
      end
    else
      @tag.body = params[:tag]
    end

    #Save tag 
    if @tag.save
      @user.increment!(:current_comment_id) if (@user.current_comment_id == params[:id].to_i)
      redirect_to next_comment, notice: "Your tag has been saved!"
    else
      redirect_to @comment, alert: 'Something went wrong!'
    end
  end

  private

    def set_user
      if !session[:user_id]
        redirect_to root_path
      else 
        @user = User.find_by(id: session[:user_id])
        if @user.nil?
          log_out
          redirect_to root_path
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      comment_id = translate_index(params[:id])
      @comment = Comment.find(comment_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.fetch(:comment, {})
    end
end
