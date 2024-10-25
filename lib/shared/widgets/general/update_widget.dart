import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:bas_app/shared/widgets/custom_button/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateWidget extends StatelessWidget {
  const UpdateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<GlobalController>(
      builder: (c) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Patch Current Version : ',
                  style: blackTextStyle,
                ),
                Text(
                  c.currentVersionApp,
                  style: blackTextStyle,
                ),
              ],
            ),
            24.verticalSpace,
            if (c.hasUpdate.value)
              if (c.isProgressUpdate.value)
                Column(
                  children: [
                    Text('Downloading Update...', style: blackTextStyle),
                    36.verticalSpace,
                    LinearProgressIndicator(
                      value: c.isProgressUpdate.value ? 1 : 0.7,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          ColorStyle.primary),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    Text('New Update Available', style: blackTextStyle),
                    8.verticalSpace,
                    Text('Patch New Version : ${c.currentPatchVersion}'),
                    36.verticalSpace,
                    if (c.updateSuccess.value)
                      SizedBox(
                        width: 1.sw / 2,
                        child: ButtonWidget(
                          text: 'Restart Now',
                          textStyle: blackTextStyle,
                          onPressed: () async {
                            await c.onRestartApp();
                          },
                          color: ColorStyle.primary,
                        ),
                      )
                    else
                      SizedBox(
                        width: 1.sw / 2,
                        child: ButtonWidget(
                          textStyle: blackTextStyle,
                          text: 'Update Now',
                          onPressed: () async {
                            await c.onUpdateApp();
                          },
                          color: ColorStyle.primary,
                        ),
                      ),
                  ],
                )
            else
              Visibility(
                visible: !c.isCheckingForUpdate.value,
                replacement: const CircularProgressIndicator(
                  color: ColorStyle.primary,
                ),
                child: Text('No Update Available', style: blackTextStyle),
              ),
            36.verticalSpace,
            ButtonWidget(
              text: 'Check For Update',
              color: ColorStyle.primary,
              textStyle: whiteTextStyle,
              onPressed: () async {
                await c.checkForUpdate();
              },
            ),
          ],
        );
      },
    );
  }
}
