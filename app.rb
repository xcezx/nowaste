# -*- coding: undecided -*-
require "rubygems"
require "sinatra"
require "haml"
require "sass"
require "sequel"
require "logger"
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require "jpmobile"
# require "jpmobile/request_with_mobile"

class Rack::Request
  include Jpmobile::RequestWithMobile
end

configure :development, :production do
  DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://nowaste.db')
end

configure :development do
  DB.loggers << Logger.new($stdout)
  ENV['USERNAME'] = 'username'
  ENV['PASSWORD'] = 'p4ssw0rd'
end

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'models')
require "outgo"
require "outgo_category"
require "income"
require "income_category"
require "balance"

helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  def protected!
    response['WWW-Authenticate'] = %(Basic realm="Private") and \
    throw(:halt, [401, "Not authorized\n"]) and \
    return unless authorized?
  end

  def authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [ENV['USERNAME'], ENV['PASSWORD']]
  end

  def partial(template, options = {})
    options = options.merge({:layout => false})
    template = "_#{template.to_s}".to_sym
    haml(template, options)
  end
end

before do
  protected!
  @title = "NoWaste"

end

# Home
get "/" do
  now = Time.now
  end_of_month = Date.new(now.year, now.month, -1)

  @title = @title + " #{now.strftime('%Y-%m')}"

  from = Time.local(now.year, now.month, 1, 0, 0, 0)
  to   = Time.local(end_of_month.year, end_of_month.month, end_of_month.day, 23, 59, 59)

  @balances = Balance.filter(:created_at => from..to).order(:created_at.desc)
  @outgo_categories = OutgoCategory.all
  @income_categories = IncomeCategory.all

  if request.mobile?
    haml "mobile/index".to_sym, :layout => "mobile/layout".to_sym
  else
    haml :index
  end
end

# --- Outgo ---
post "/outgo/add" do
  DB.transaction do
    outgo = Outgo.create(params[:outgo])
    balance = Balance.create(:outgo_id => outgo.id)
  end

  redirect "/"
end

# get "/outgo/edit/:id" do
# end

# put "/outgo/update" do
# end

# delete "/outgo/delete/:id" do
# end

# --- Income ---
post "/income/add" do
  DB.transaction do
    income = Income.create(params[:income])
    balance = Balance.create(:income_id => income.id)
  end

  redirect "/"
end

# get "/income/edit/:id" do
# end

# put "/income/update" do
# end

# delete "/income/delete/:id" do
# end










