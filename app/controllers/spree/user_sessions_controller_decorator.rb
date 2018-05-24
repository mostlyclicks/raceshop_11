class Spree::UserSessionsController < Devise::SessionsController

  # before_action :switch_to_brand


	def switch_to_brand(brand)
    if brand == "Rossignol"
      redirect_to 'http://rs11.herokuapp.com/t/rossignol'
    elsif brand == "Dynastar"
      redirect_to 'http://rs11.herokuapp.com/t/dynastar'
    elsif brand == "Coach"
      redirect_to 'http://rs11.herokuapp.com/t/coach'
    end
  end



  def create
  authenticate_spree_user!

    if spree_user_signed_in?
      respond_to do |format|
        format.html do

          brand = current_spree_user.athlete_brand
          puts brand
          if brand == "Rossignol"
            redirect_to 'http://rs11.herokuapp.com/t/rossignol'
          elsif brand == "Dynastar"
            redirect_to 'http://rs11.herokuapp.com/t/dynastar'
          elsif brand == "Coach"
            redirect_to 'http://rs11.herokuapp.com/t/coach'
          end
          puts brand + " hello"



          flash[:success] = Spree.t(:logged_in_succesfully)
          # redirect_back_or_default(after_sign_in_path_for(spree_current_user))
          #switch_to_brand(current_spree_user.athlete_brand)



        end
        format.js { render success_json }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = t('devise.failure.invalid')
          render :new
        end
        format.js do
          render json: { error: t('devise.failure.invalid') },
            status: :unprocessable_entity
        end
      end
    end
  end

end