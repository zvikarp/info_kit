import 'package:flutter/material.dart';

class InfoSize {
  final BoxConstraints constraints;
  const InfoSize(this.constraints);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InfoSize && other.constraints == constraints;
  }

  @override
  int get hashCode => constraints.hashCode;
}
