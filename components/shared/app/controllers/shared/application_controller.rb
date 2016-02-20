module Shared
class ApplicationController < ActionController::Base
  helper Mooc::Engine.helpers if Rails.module.mooc?

  protected

  # concerns order is significant
  include Shared::Applications::Security
  include Shared::Applications::Flash
  include Shared::Applications::Form
  include Shared::Applications::Tab

  include Shared::Events::Log

  include Shared::Facebook::Modal
  include Shared::Slido::Flash
  include (Rails.module.classify + '::Application').constantize

  before_action :determine_context

  def current_ability
    @current_ability ||= Shared::Ability.new(current_user)
  end

  def determine_context
    @context = session[:context] = params[:context] if params[:context]
    @context = session[:context] if session[:context]
    @context = :root if @context.nil?

    Shared::ApplicationHelper.current_context=(@context)
  end
end
end
