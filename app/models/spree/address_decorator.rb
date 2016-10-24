# module Spree
#   Address.class_eval do
#     _validators.reject!{ |key, value| key == :zipcode }
#     _validate_callbacks.each do |callback|
#       callback.raw_filter.attributes.reject! { |key| key == :zipcode } if callback.raw_filter.respond_to?(:attributes)
#     end
#   end
# end
Spree::Address.class_eval do
  def require_zipcode?
    false
  end

  def state_validate
    true
  end

end