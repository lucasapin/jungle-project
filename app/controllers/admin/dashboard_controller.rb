class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: "Jungle", password: "book"

  def show
    @categories = Category.count
    @products = Product.count
  end
end
