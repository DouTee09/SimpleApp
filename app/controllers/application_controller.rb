class ApplicationController < ActionController::Base
  def hello
    render html: "hello, world!"
  end
  def home; end
  def help; end
  def about; end
  def contact; end
end
