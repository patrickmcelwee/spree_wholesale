Deface::Override.new(virtual_path: "spree/admin/configurations/index",
                    name: 'admin-configuration',
                    insert_bottom: "[data-hook='admin_configurations_menu']",
                    text: "<%= configurations_menu_item(I18n.t('wholesale'),
                           admin_wholesale_configurations_path,
                           I18n.t('manage_wholesale_configurations')) %>"
                    )
