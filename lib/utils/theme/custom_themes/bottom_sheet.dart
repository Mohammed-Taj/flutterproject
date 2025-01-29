import 'package:flutter/material.dart';

class TBottomSheet {
  TBottomSheet._();
  static final BottomSheetThemeData lightBottomSheetTheme =
      BottomSheetThemeData(
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    showDragHandle: true,
    constraints: BoxConstraints(minWidth: double.infinity),
  );
  static final BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    backgroundColor: Colors.black,
    modalBackgroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    showDragHandle: true,
    constraints: BoxConstraints(minWidth: double.infinity),
  );
}
