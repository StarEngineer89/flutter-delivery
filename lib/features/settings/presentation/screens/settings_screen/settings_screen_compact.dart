import 'package:flutter/material.dart';

import '../../../../../core/presentation/screens/nested_screen_wrapper.dart';
import '../../../../../core/presentation/styles/sizes.dart';
import '../../../../../core/presentation/utils/scroll_behaviors.dart';
import '../../components/settings_components/app_settings_section_component.dart';
import '../../components/settings_components/logout_component.dart';
import '../../components/settings_components/user_details_component.dart';

class SettingsScreenCompact extends StatelessWidget {
  const SettingsScreenCompact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScreenWrapper(
      body: ScrollConfiguration(
        behavior: MainScrollBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.screenMarginV20,
              horizontal: Sizes.screenMarginH36,
            ),
            child: Column(
              children: const [
                UserDetailsComponent(),
                SizedBox(
                  height: Sizes.marginV12,
                ),
                AppSettingsSectionComponent(),
                SizedBox(
                  height: Sizes.marginV20,
                ),
                LogoutComponent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
