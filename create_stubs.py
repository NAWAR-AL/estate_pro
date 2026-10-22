import os
import sys

files = [
  'lib/features/properties/presentation/pages/properties_page.dart',
  'lib/features/properties/presentation/pages/properties_details_page.dart',
  'lib/features/service/presentation/pages/services_page.dart',
  'lib/features/blog/presentation/pages/blog_page.dart',
  'lib/features/blog/presentation/pages/blog_details_page.dart',
  'lib/features/pages/search_page.dart',
  'lib/features/pages/profile_page.dart',
  'lib/features/about/presentation/pages/about_page.dart',
  'lib/features/about/presentation/pages/contact_page.dart',
  'lib/features/dashbord/admin/presentation/pages/admin_dashbord_page.dart',
  'lib/features/dashbord/admin/presentation/pages/users_managment_page.dart',
  'lib/features/dashbord/admin/presentation/pages/properties_managment_page.dart',
  'lib/features/dashbord/admin/presentation/pages/blog_managment_page.dart',
  'lib/features/dashbord/admin/presentation/pages/services_managment_page.dart',
  'lib/features/dashbord/admin/presentation/pages/message_page.dart',
  'lib/features/dashbord/user/presentation/pages/user_dashbord_page.dart',
  'lib/features/dashbord/user/presentation/pages/favorites_page.dart',
  'lib/features/dashbord/user/presentation/pages/reviews_page.dart',
  'lib/features/widgets/custom_appbar.dart',
  'lib/features/widgets/custom_bottom_navbar.dart',
  'lib/features/widgets/custom_button.dart',
  'lib/features/widgets/custom_drawer.dart',
]

base = r'D:\flutter_apps\estate_pro'
for f in files:
    p = os.path.join(base, f)
    d = os.path.dirname(p)
    os.makedirs(d, exist_ok=True)
    name = os.path.basename(f).replace('.dart', '')
    cls = ''.join(w.capitalize() for w in name.split('_'))
    title = cls.replace('Page', '')
    with open(p, 'w', encoding='utf-8') as fh:
        fh.write("import 'package:flutter/material.dart';\n\n")
        fh.write(f'class {cls} extends StatelessWidget {{\n')
        fh.write(f'  const {cls}({{super.key}});\n\n')
        fh.write('  @override\n')
        fh.write('  Widget build(BuildContext context) {\n')
        fh.write('    return Scaffold(\n')
        fh.write(f'      appBar: AppBar(title: const Text(\'{title}\')),\n')
        fh.write(f'      body: const Center(child: Text(\'{cls}\')),\n')
        fh.write('    );\n')
        fh.write('  }\n')
        fh.write('}\n')

print('done')
