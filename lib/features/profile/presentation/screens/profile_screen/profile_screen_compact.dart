import 'package:deliverzler/core/presentation/screens/nested_screen_wrapper.dart';
import 'package:deliverzler/core/presentation/utils/scroll_behaviors.dart';
import 'package:deliverzler/features/profile/presentation/components/profile_form_component.dart';
import 'package:deliverzler/features/profile/presentation/components/profile_header_component.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/core/presentation/styles/sizes.dart';

class ProfileScreenCompact extends StatelessWidget {
  const ProfileScreenCompact({Key? key}) : super(key: key);

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
                ProfileHeaderComponent(),
                SizedBox(
                  height: Sizes.marginV28,
                ),
                ProfileFormComponent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
