class TestController < ApplicationController
  def index; end
  def show; end
  def new; end
  def edit; end
  def create; end
  def update; end
  def destroy; end

  private

  def default_render
    render plain: "#{params[:controller]}##{params[:action]}"
  end
end
