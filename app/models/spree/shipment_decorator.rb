Spree::Shipment.class_eval do
  self.whitelisted_ransackable_attributes = ['number', 'state']
end