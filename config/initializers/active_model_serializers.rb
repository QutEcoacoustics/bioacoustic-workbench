
Rails.logger.info 'Disable root globally for in ArraySerializer'

# HACK!
ActiveModel::ArraySerializer.root = false

# THIS IS WHAT IT IS MEANT TO BE BUT IT DOES NOT WORK
# disable root json element
ActiveSupport.on_load(:active_model_serializers) do
  self.root = false
end