class SuperMagicLinksController < ApplicationController
  def index
    super_magic_user = User.find_super_magic_session(session[:super_magic_token])

    if super_magic_user&.🍄
      reset_session
      sign_in super_magic_user
      redirect_to root_path
    end
  end

  def create
    reset_session
    user = User.find_by(email: params[:user][:email]) || User.create(email: params[:user][:email], password: SecureRandom.uuid)
    session[:super_magic_token] = user.create_super_magic_link

    if Rails.env.development?
      Clipboard.copy(open_super_magic_link_url(session[:super_magic_token]))
    end

    render :index
  end

  def open
    if (user = User.find_super_magic_token(params[:id]))
      user.touch(:super_magic_token_opened_at)
      render html: "🍄 You are now logged in"
    else
      render html: "not found", status: 404
    end
  end
end
