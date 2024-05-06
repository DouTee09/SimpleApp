class StaticPagesController < ActionController::Base
  def hello
    render html: "hello, world!"
  end
  def home; end
  def help; end
end
