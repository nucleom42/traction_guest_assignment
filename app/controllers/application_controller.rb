class ApplicationController < ActionController::Base
  # skipping for testing purpose
  skip_before_action :verify_authenticity_token, if: proc { Rails.env.development? }
end
