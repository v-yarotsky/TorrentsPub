require 'delegate'

module Slapjack
  class AuthenticationProxy < SimpleDelegator
    class LoginError < RuntimeError
      def message
        "Login failed. Check credentials (or maybe refreshing too often?)"
      end
    end

    abstract_method :login
    abstract_method :logout

    private

    def method_missing(m, *args, &block)
      debug_message "Authenticating #{m}"
      login
      super
    ensure
      logout
    end
  end
end

