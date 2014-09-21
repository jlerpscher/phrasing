require 'phrasing'
require "phrasing/serializer"
require 'jquery-rails'
require 'jquery-cookie-rails'
require 'haml-rails'

module Phrasing
  module Rails
    class Engine < ::Rails::Engine
      initializer :assets, group: :all do
        ::Rails.application.config.assets.paths << ::Rails.root.join('app', 'assets', 'fonts')
        ::Rails.application.config.assets.paths << ::Rails.root.join('app', 'assets', 'images')
        ::Rails.application.config.assets.precompile +=  %w(editor.js
                                                            phrasing_engine.css
                                                            phrasing_engine.js
                                                            icomoon.dev.svg
                                                            icomoon.svg
                                                            icomoon.eot
                                                            icomoon.ttf
                                                            icomoon.woff
                                                            phrasing_icon_edit_all.png)
      end
    end
  end
end


module Phrasing

  mattr_accessor :allow_update_on_all_models_and_attributes
  mattr_accessor :route

  @@route = 'phrasing'

  def self.setup
    yield self
  end

  WHITELIST = "PhrasingPhrase.value"

  def self.whitelist
    if defined? @@whitelist
      @@whitelist + [WHITELIST]
    else
      [WHITELIST]
    end
  end

  def self.whitelist=(whitelist)
    @@whitelist = whitelist
  end

  def self.is_whitelisted?(klass,attribute)
    allow_update_on_all_models_and_attributes == true or whitelist.include? "#{klass}.#{attribute}"
  end
end