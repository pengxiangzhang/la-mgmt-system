# Be sure to restart your server when you modify this file.

# Specify a serializer for the signed and encrypted cookie jars.
# Valid options are :json, :marshal, and :hybrid.
Rails.application.config.action_dispatch.cookies_serializer = :json

require 'rack-cas/session_store/rails/active_record'
Rails.application.config.session_store ActionDispatch::Session::RackCasActiveRecordStore
