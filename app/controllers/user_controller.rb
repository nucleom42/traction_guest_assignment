# frozen_string_literal: true

class UserController < ApplicationController
  class NoUserFound < StandardError; end

  def index
    users =
      Users::Filterer.new(user: users_params, gov: gov_params, single_result: single_result_params[:single_result]).call

    render(json: users.includes(:gov), each_serializer: UserSerializer)
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_request
  end

  def destroy
    id = users_params[:id]
    User.find(id).destroy!

    render json: { ok: id }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_request
  end

  # not restfull, though meet reqs.
  def extended_destroy
    users =
      Users::Filterer.new(user: users_params, gov: gov_params, **forced_single_result_params).call

    user_for_deletion = users.last
    raise NoUserFound, 'no user found' unless user_for_deletion

    user_id_for_deletion = user_for_deletion.id
    user_for_deletion.destroy!

    render json: { ok: user_id_for_deletion }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def forced_single_result_params
    { single_result: true }
  end

  def gov_params
    params.permit(:gov_id_type).to_h.symbolize_keys
  end

  def users_params
    params.permit(:id, :first_name, :last_name, :email, :gov_id_number).to_h.symbolize_keys
  end

  def single_result_params
    params.permit(:single_result).to_h.symbolize_keys
  end
end
