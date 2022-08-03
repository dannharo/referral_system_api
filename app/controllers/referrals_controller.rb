class ReferralsController < ApplicationController

  def index
    render json: Referral.all, except: [:created_at, :updated_at]
  end

  def create

  end

  def show

  end

  def update

  end

  def destroy

  end

  private

  def referral_params
    params.permit([:referred_by, :full_name, :phone_number, :email, :linkedin_url, :cv_url, :tech_stack, :ta_recruiter, :status, :comments])
  end

  def invalid_params_error
    unless params[:id].match? /\A\d+\z/
      message = 'ID is not a numeric value'
      Rails.logger.error(message)
      render json: {
        'message': 'Invalid parameter',
        'errors': [message]
      }, status: :unprocessable_entity
    end
  end
end
