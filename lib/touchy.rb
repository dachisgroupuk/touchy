require "touchy/version"

require 'active_support'

require 'touchy/controller'
require 'touchy/model'

module Touchy
  def self.current_user
    touchy_store[:current_user]
  end

  def self.current_user=(value)
    touchy_store[:current_user] = value
  end
  
  
  private

  def self.touchy_store
    Thread.current[:touchy] ||= {}
  end
end

ActiveSupport.on_load(:active_record) do
  include Touchy::Model
end

ActiveSupport.on_load(:action_controller) do
  include Touchy::Controller
end
