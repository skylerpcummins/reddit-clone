class SubsController < ApplicationController
  before_action :require_moderator, only: [:edit, :update]
  before_action :require_login, except: [:index, :show]

  def new
    @sub = Sub.new
  end

  def create
    # @sub = Sub.new(sub_params)
    # @sub.moderator_id = current_user.id

    @sub = current_user.subs.new(sub_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    @subs = Sub.all
  end

  def require_moderator
    redirect_to root_url unless current_user.id.to_s == params[:id]
  end

  def require_login
    redirect_to new_session_url unless logged_in?
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
