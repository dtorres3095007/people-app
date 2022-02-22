import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

DialogType tipyAlerts(type) {
  DialogType typeResp = DialogType.SUCCES;
  switch (type) {
    case 'info':
      typeResp = DialogType.INFO;
      break;
    case 'warning':
      typeResp = DialogType.WARNING;
      break;
    case 'error':
      typeResp = DialogType.ERROR;
      break;
    default:
      typeResp = DialogType.SUCCES;
  }
  return typeResp;
}

void showAlert(BuildContext context, String titile, String message, String type,
    {btnCancelOnPress, btnOkOnPress, btnCancelText, btnOkText, callbackClose}) {
  DialogType typeDialog = tipyAlerts(type);
  AwesomeDialog(
    // autoHide: type == 'success' ? const Duration(seconds: 5) : null,
    context: context,
    dialogType: typeDialog,
    headerAnimationLoop: false,
    animType: AnimType.SCALE,
    showCloseIcon: true,
    closeIcon: const Icon(Icons.close),
    btnCancelText: btnCancelText ?? 'No',
    btnOkText: btnOkText ?? 'Si',
    btnOkColor: const Color(0xff296DC8),
    title: titile,
    desc: message,
    btnCancelOnPress: btnCancelOnPress == null
        ? () {
            Navigator.pop(context, false);
          }
        : () => btnCancelOnPress(),
    onDissmissCallback:
        callbackClose == null ? null : (type) => callbackClose(),
    btnOkOnPress: btnOkOnPress == null ? () {} : () => btnOkOnPress(),
  ).show();
}
