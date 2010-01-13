# -*- coding: undecided -*-
require "rubygems"
require "sinatra"
require "haml"
require "sass"
require "sequel"
require "logger"

configure :development, :production do
  DB = Sequel.connect(:adapter => "sqlite", :database => "nowaste.db")
  DB.loggers << Logger.new($stdout)
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
end


get "/" do
  @balances = Balance.all
  @outgo_categories = OutgoCategory.all
  @income_categories = IncomeCategory.all
  haml :index
end


post "/outgo/add" do
  DB.transaction do
    outgo = Outgo.create(params[:outgo])
    balance = Balance.create(:outgo_id => outgo.id)
  end

  redirect "/"
end

post "/income/add" do
  DB.transaction do
    income = Income.create(params[:income])
    balance = Balance.create(:income_id => income.id)
  end

  redirect "/"
end
