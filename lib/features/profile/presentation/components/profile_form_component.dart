import 'package:flutter/material.dart';

import '../../../../auth/presentation/providers/auth_state_provider.dart';
import '../../../../core/domain/entities/event.dart';
import '../../../../core/presentation/helpers/localization_helper.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/utils/fp_framework.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../core/presentation/widgets/custom_button.dart';
import '../providers/update_profile_data_provider.dart';
import 'profile_text_fields_section.dart';

class ProfileFormComponent extends HookConsumerWidget {
  const ProfileFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.easyListen(updateProfileDataStateProvider);

    final user = ref.watch(currentUserProvider);

    final profileFormKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController(text: user.name ?? '');
    final mobileController = useTextEditingController(text: user.phone ?? '');

    void updateProfile() {
      if (profileFormKey.currentState!.validate()) {
        final params = user.copyWith(
          name: nameController.text,
          phone: mobileController.text,
        );
        ref
            .read(updateProfileDataEventProvider.notifier)
            .update((_) => Some(Event.unique(params)));
      }
    }

    return Form(
      key: profileFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: Sizes.maxWidth360,
            ),
            child: ProfileTextFieldsSection(
              nameController: nameController,
              mobileController: mobileController,
            ),
          ),
          const SizedBox(
            height: Sizes.marginV36,
          ),
          CustomButton(
            text: tr(context).confirm,
            onPressed: ref.isLoading(updateProfileDataStateProvider)
                ? null
                : updateProfile,
          ),
        ],
      ),
    );
  }
}
