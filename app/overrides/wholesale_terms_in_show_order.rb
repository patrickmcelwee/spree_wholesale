Deface::Override.new(virtual_path: 'spree/orders/show',
                     name: 'wholesale_terms_in_show_order',
                     insert_before: "div#order[data-hook]",
                     partial: 'spree/hooks/wholesale_terms_reminder')
