class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :switch_to_brand

  # def redirect_to_brand(brand)
  # 	if brand == "Rossignol"
  # 		redirect_to '/t/rossignol'
  # 	elsif brand == "Dynastar"
  # 		redirect_to '/t/dynastar'
  # 	elsif brand == "Coach"
  # 		redirect_to '/t/coach'
  # 	end
  # end




end
