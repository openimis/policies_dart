// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'invoice_price_component_type_coding.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InvoicePriceComponentTypeCoding _$InvoicePriceComponentTypeCodingFromJson(
    Map<String, dynamic> json) {
  return _InvoicePriceComponentTypeCoding.fromJson(json);
}

/// @nodoc
class _$InvoicePriceComponentTypeCodingTearOff {
  const _$InvoicePriceComponentTypeCodingTearOff();

  _InvoicePriceComponentTypeCoding call(
      {FhirUri system = const FhirUri.asConst(
          "http://hl7.org/fhir/invoice-priceComponentType",
          ConstUri("http://hl7.org/fhir/invoice-priceComponentType"),
          true),
      required InvoicePriceComponentTypeCode code}) {
    return _InvoicePriceComponentTypeCoding(
      system: system,
      code: code,
    );
  }

  InvoicePriceComponentTypeCoding fromJson(Map<String, Object?> json) {
    return InvoicePriceComponentTypeCoding.fromJson(json);
  }
}

/// @nodoc
const $InvoicePriceComponentTypeCoding =
    _$InvoicePriceComponentTypeCodingTearOff();

/// @nodoc
mixin _$InvoicePriceComponentTypeCoding {
  FhirUri get system => throw _privateConstructorUsedError;
  InvoicePriceComponentTypeCode get code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvoicePriceComponentTypeCodingCopyWith<InvoicePriceComponentTypeCoding>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoicePriceComponentTypeCodingCopyWith<$Res> {
  factory $InvoicePriceComponentTypeCodingCopyWith(
          InvoicePriceComponentTypeCoding value,
          $Res Function(InvoicePriceComponentTypeCoding) then) =
      _$InvoicePriceComponentTypeCodingCopyWithImpl<$Res>;
  $Res call({FhirUri system, InvoicePriceComponentTypeCode code});
}

/// @nodoc
class _$InvoicePriceComponentTypeCodingCopyWithImpl<$Res>
    implements $InvoicePriceComponentTypeCodingCopyWith<$Res> {
  _$InvoicePriceComponentTypeCodingCopyWithImpl(this._value, this._then);

  final InvoicePriceComponentTypeCoding _value;
  // ignore: unused_field
  final $Res Function(InvoicePriceComponentTypeCoding) _then;

  @override
  $Res call({
    Object? system = freezed,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      system: system == freezed
          ? _value.system
          : system // ignore: cast_nullable_to_non_nullable
              as FhirUri,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as InvoicePriceComponentTypeCode,
    ));
  }
}

/// @nodoc
abstract class _$InvoicePriceComponentTypeCodingCopyWith<$Res>
    implements $InvoicePriceComponentTypeCodingCopyWith<$Res> {
  factory _$InvoicePriceComponentTypeCodingCopyWith(
          _InvoicePriceComponentTypeCoding value,
          $Res Function(_InvoicePriceComponentTypeCoding) then) =
      __$InvoicePriceComponentTypeCodingCopyWithImpl<$Res>;
  @override
  $Res call({FhirUri system, InvoicePriceComponentTypeCode code});
}

/// @nodoc
class __$InvoicePriceComponentTypeCodingCopyWithImpl<$Res>
    extends _$InvoicePriceComponentTypeCodingCopyWithImpl<$Res>
    implements _$InvoicePriceComponentTypeCodingCopyWith<$Res> {
  __$InvoicePriceComponentTypeCodingCopyWithImpl(
      _InvoicePriceComponentTypeCoding _value,
      $Res Function(_InvoicePriceComponentTypeCoding) _then)
      : super(_value, (v) => _then(v as _InvoicePriceComponentTypeCoding));

  @override
  _InvoicePriceComponentTypeCoding get _value =>
      super._value as _InvoicePriceComponentTypeCoding;

  @override
  $Res call({
    Object? system = freezed,
    Object? code = freezed,
  }) {
    return _then(_InvoicePriceComponentTypeCoding(
      system: system == freezed
          ? _value.system
          : system // ignore: cast_nullable_to_non_nullable
              as FhirUri,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as InvoicePriceComponentTypeCode,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InvoicePriceComponentTypeCoding
    implements _InvoicePriceComponentTypeCoding {
  _$_InvoicePriceComponentTypeCoding(
      {this.system = const FhirUri.asConst(
          "http://hl7.org/fhir/invoice-priceComponentType",
          ConstUri("http://hl7.org/fhir/invoice-priceComponentType"),
          true),
      required this.code});

  factory _$_InvoicePriceComponentTypeCoding.fromJson(
          Map<String, dynamic> json) =>
      _$$_InvoicePriceComponentTypeCodingFromJson(json);

  @JsonKey()
  @override
  final FhirUri system;
  @override
  final InvoicePriceComponentTypeCode code;

  @override
  String toString() {
    return 'InvoicePriceComponentTypeCoding(system: $system, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InvoicePriceComponentTypeCoding &&
            const DeepCollectionEquality().equals(other.system, system) &&
            const DeepCollectionEquality().equals(other.code, code));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(system),
      const DeepCollectionEquality().hash(code));

  @JsonKey(ignore: true)
  @override
  _$InvoicePriceComponentTypeCodingCopyWith<_InvoicePriceComponentTypeCoding>
      get copyWith => __$InvoicePriceComponentTypeCodingCopyWithImpl<
          _InvoicePriceComponentTypeCoding>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InvoicePriceComponentTypeCodingToJson(this);
  }
}

abstract class _InvoicePriceComponentTypeCoding
    implements InvoicePriceComponentTypeCoding {
  factory _InvoicePriceComponentTypeCoding(
          {FhirUri system, required InvoicePriceComponentTypeCode code}) =
      _$_InvoicePriceComponentTypeCoding;

  factory _InvoicePriceComponentTypeCoding.fromJson(Map<String, dynamic> json) =
      _$_InvoicePriceComponentTypeCoding.fromJson;

  @override
  FhirUri get system;
  @override
  InvoicePriceComponentTypeCode get code;
  @override
  @JsonKey(ignore: true)
  _$InvoicePriceComponentTypeCodingCopyWith<_InvoicePriceComponentTypeCoding>
      get copyWith => throw _privateConstructorUsedError;
}
