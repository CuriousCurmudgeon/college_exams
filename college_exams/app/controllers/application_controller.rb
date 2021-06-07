class ApplicationController < ActionController::API
  before_action :log_api_request

  private

  def log_api_request
    ApiRequest.create(
      endpoint: request.fullpath,
      remote_ip: request.remote_ip,
      payload: params,
      created_at: Time.now.iso8601
    )
  end
end
