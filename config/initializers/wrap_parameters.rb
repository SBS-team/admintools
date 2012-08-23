# Be sure to restart your server when you modify this file.                                                          <%= sanitize @questionable.to_json(methods: [:id_with_class_name], only: [:id, :name]) %>
#
# This file contains settings for ActionController::ParamsWrapper which
# is enabled by default.

# Enable parameter wrapping for JSON. You can disable this by setting :format to an empty array.
ActiveSupport.on_load(:action_controller) do
  wrap_parameters format: [:json]
end

# Disable root element in JSON by default.
ActiveSupport.on_load(:active_record) do
  self.include_root_in_json = false
end
