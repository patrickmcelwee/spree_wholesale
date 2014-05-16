Deface::Override.new(virtual_path: "spree/admin/shared/_configuration_menu",
                    name: 'admin-configuration',
                    insert_bottom: "[data-hook='admin_configurations_sidebar_menu']",
                    text: "<%= configurations_sidebar_menu_item(t('wholesale'),
                           admin_wholesale_configurations_path) %>"
                    )
