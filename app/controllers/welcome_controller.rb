class WelcomeController < ApplicationController
  swagger_controller :welcome, "Welcome is an example"

  swagger_api :index do
    summary "This is a Summary of a GET Action"
    notes "You can add some notes"
    param :path, :id, :integer, :optional, "This is a path PARAM"
    response :bad_request, "This is a bad request"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :ok, "Success"
  end

  def index
    response = {
      greeting: 'GET action tested successfully '
    }

    render 200, json: response
  end

  swagger_api :create do
    summary "This is a Summary of a POST Action"
    notes "You can add some notes"
    param :path, :id, :integer, :optional, "Path Param"
    param :body, :body, :string, :required, "Body Param"
    param :form, :last_name, :string, :required, "Form Param"
    param :form, :email, :string, :required, "Form Param"
    param_list :form, :role, :string, :required, "Param List", [ "admin", "superadmin", "user" ]
    param :header, 'Content-Type', :string, :required, "Content Type"
    response :unauthorized
    response :bad_request, "This is a bad request"
    response :not_acceptable, "The request you made is not acceptable"
    response :ok, "Success"
  end

  def create
    response = {
      greeting: 'POST action tested successfully'
    }

    render 200, json: response
  end
end
