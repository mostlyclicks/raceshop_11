class Spree::UserSessionsController < Devise::SessionsController

  # before_action :switch_to_brand


	def switch_to_brand(brand)
    if brand == "Rossignol"
      redirect_to '/t/rossignol'
    elsif brand == "Dynastar"
      redirect_to '/t/dynastar'
    elsif brand == "Coach"
      redirect_to '/t/coach'
    end
  end



  def create
  authenticate_spree_user!

    if spree_user_signed_in?
      respond_to do |format|
        format.html do
          flash[:success] = Spree.t(:logged_in_succesfully)
          # redirect_back_or_default(after_sign_in_path_for(spree_current_user))
          #switch_to_brand(current_spree_user.athlete_brand)

          brand = current_spree_user.athlete_brand
          
          if brand == "Rossignol"
            redirect_to '/t/rossignol'
          elsif brand == "Dynastar"
            redirect_to '/t/dynastar'
          elsif brand == "Coach"
            redirect_to '/t/coach'
          end

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