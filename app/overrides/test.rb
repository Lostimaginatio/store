Deface::Override.new(:virtual_path  => "spree/home/index",
                     :insert_before => "[data-hook=\"homepage_products\"]",
                     :text          => "<p>Registration is the future!</p>",
                     :name          => "registration_future")