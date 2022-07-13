# frozen_string_literal: true

module Users
  class Filterer
    class TooManyRecords < StandardError; end

    def initialize(args = {})
      @users = User.all
      @filters = args
    end

    def call
      @users = @users.where(**@filters[:user]) if @filters[:user]&.any?
      @users = @users.joins(:gov).where(govs: { **@filters[:gov] }) if @filters[:gov]&.any?

      raise TooManyRecords, 'too many records' if violate_single_result?

      @users
    end

    private

    def violate_single_result?
      @filters[:single_result] && @users.length > 1
    end
  end
end
