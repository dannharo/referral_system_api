module Api
  module V1
    class ReferralCommentsController < ApplicationController
      before_action :authenticate_user!
      load_and_authorize_resource :referral
      load_and_authorize_resource :referral_comment, through: :referral

      swagger_controller :referral_comments, "Referral Comments Management Endpoint"

      swagger_api :index do
        summary "Fetches all Referrals comments per Referral"
        notes "This lists all the referral comments"

        response :ok
        response :not_found, "Record not found"
        response :internal_server_error, "Error while creating a new record"
      end

      def index
        comments = current_referral.referral_comments
        log_debug("Fetching referral comments with email #{current_referral.email}")
        mapped_comments = comments.map { |comment| map_comment(comment) }

        render json: mapped_comments
      rescue ActiveRecord::RecordNotFound => e
        log_error("Error, referral id = #{params[:referral_id]} record not found")

        render json: {
          message: "Record not found",
          errors: [e.message],
        }, status: :not_found
      end

      swagger_api :create do
        summary "Create a Referral Comment"
        notes "This creates a new referral comment"
        param :form, :referral_status_id, :integer, :optional, "Status of the referral when commented"
        param :form, :comment, :string, :optional, "Comment for referral"
        response :created
        response :unprocessable_entity, "Error, the transaction has failed"
        response :internal_server_error, "Error while creating a new record"
      end

      def create
        new_comment_params = new_comment(referral_comment_params)
        comment =  current_referral.referral_comments.new(new_comment_params)
        ActiveRecord::Base.transaction do
          comment.save!

          log_debug("New referral comment created for referral: #{current_referral.id} by #{current_user.email}")
        end
        render json: {}, status: :created
      rescue ActiveRecord::RecordInvalid => e
        log_error(e.message)
        render json: { message: "Bad Request", errors: [e.message] }, status: :bad_request
      end

      private

      def current_referral
        @current_referral ||= Referral.find(params[:referral_id])
      end

      def referral_comment_params
        params.require(:referral_comment).permit(%i[referral_status_id comment])
      end

      def map_comment(comment)
        {
          content: comment.comment,
          creator: comment.created_by_name,
          comment_date: comment.created_at.strftime("%b %-d, %Y"),
          status: comment.referral_status_id
        }
      end

      def new_comment(comment_params)
        comment_params.merge!({
          created_by_id: current_user.id,
          created_by_name: current_user&.name
        })
      end
    end
  end
end
