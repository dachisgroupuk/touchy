module Touchy
  module Controller
    
    def self.included(base)
      base.before_filter :set_touchy_current_user
    end
    
    def user_for_touchy
      current_user rescue nil
    end
    
    def set_touchy_current_user
      ::Touchy.current_user = user_for_touchy
    end
    
  end
end
