// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'identifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Identifier _$IdentifierFromJson(Map<String, dynamic> json) {
  return _Identifier.fromJson(json);
}

/// @nodoc
class _$IdentifierTearOff {
  const _$IdentifierTearOff();

  _Identifier call(
      {String? id,
      List<Extension>? extension,
      IdentifierUseCode? use,
      CodeableConcept<OpenimisIdentifiersCoding>? type,
      FhirUri? system,
      String? value,
      Period? period,
      Reference? assigner}) {
    return _Identifier(
      id: id,
      extension: extension,
      use: use,
      type: type,
      system: system,
      value: value,
      period: period,
      assigner: assigner,
    );
  }

  Identifier fromJson(Map<String, Object?> json) {
    return Identifier.fromJson(json);
  }
}

/// @nodoc
const $Identifier = _$IdentifierTearOff();

/// @nodoc
mixin _$Identifier {
  String? get id => throw _privateConstructorUsedError;
  List<Extension>? get extension => throw _privateConstructorUsedError;
  IdentifierUseCode? get use => throw _privateConstructorUsedError;
  CodeableConcept<OpenimisIdentifiersCoding>? get type =>
      throw _privateConstructorUsedError;
  FhirUri? get system => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  Period? get period => throw _privateConstructorUsedError;
  Reference? get assigner => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IdentifierCopyWith<Identifier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IdentifierCopyWith<$Res> {
  factory $IdentifierCopyWith(
          Identifier value, $Res Function(Identifier) then) =
      _$IdentifierCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      List<Extension>? extension,
      IdentifierUseCode? use,
      CodeableConcept<OpenimisIdentifiersCoding>? type,
      FhirUri? system,
      String? value,
      Period? period,
      Reference? assigner});

  $CodeableConceptCopyWith<OpenimisIdentifiersCoding, $Res>? get type;
  $PeriodCopyWith<$Res>? get period;
  $ReferenceCopyWith<$Res>? get assigner;
}

/// @nodoc
class _$IdentifierCopyWithImpl<$Res> implements $IdentifierCopyWith<$Res> {
  _$IdentifierCopyWithImpl(this._value, this._then);

  final Identifier _value;
  // ignore: unused_field
  final $Res Function(Identifier) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? extension = freezed,
    Object? use = freezed,
    Object? type = freezed,
    Object? system = freezed,
    Object? value = freezed,
    Object? period = freezed,
    Object? assigner = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      extension: extension == freezed
          ? _value.extension
          : extension // ignore: cast_nullable_to_non_nullable
              as List<Extension>?,
      use: use == freezed
          ? _value.use
          : use // ignore: cast_nullable_to_non_nullable
              as IdentifierUseCode?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CodeableConcept<OpenimisIdentifiersCoding>?,
      system: system == freezed
          ? _value.system
          : system // ignore: cast_nullable_to_non_nullable
              as FhirUri?,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      period: period == freezed
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as Period?,
      assigner: assigner == freezed
          ? _value.assigner
          : assigner // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ));
  }

  @override
  $CodeableConceptCopyWith<OpenimisIdentifiersCoding, $Res>? get type {
    if (_value.type == null) {
      return null;
    }

    return $CodeableConceptCopyWith<OpenimisIdentifiersCoding, $Res>(
        _value.type!, (value) {
      return _then(_value.copyWith(type: value));
    });
  }

  @override
  $PeriodCopyWith<$Res>? get period {
    if (_value.period == null) {
      return null;
    }

    return $PeriodCopyWith<$Res>(_value.period!, (value) {
      return _then(_value.copyWith(period: value));
    });
  }

  @override
  $ReferenceCopyWith<$Res>? get assigner {
    if (_value.assigner == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.assigner!, (value) {
      return _then(_value.copyWith(assigner: value));
    });
  }
}

/// @nodoc
abstract class _$IdentifierCopyWith<$Res> implements $IdentifierCopyWith<$Res> {
  factory _$IdentifierCopyWith(
          _Identifier value, $Res Function(_Identifier) then) =
      __$IdentifierCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      List<Extension>? extension,
      IdentifierUseCode? use,
      CodeableConcept<OpenimisIdentifiersCoding>? type,
      FhirUri? system,
      String? value,
      Period? period,
      Reference? assigner});

  @override
  $CodeableConceptCopyWith<OpenimisIdentifiersCoding, $Res>? get type;
  @override
  $PeriodCopyWith<$Res>? get period;
  @override
  $ReferenceCopyWith<$Res>? get assigner;
}

/// @nodoc
class __$IdentifierCopyWithImpl<$Res> extends _$IdentifierCopyWithImpl<$Res>
    implements _$IdentifierCopyWith<$Res> {
  __$IdentifierCopyWithImpl(
      _Identifier _value, $Res Function(_Identifier) _then)
      : super(_value, (v) => _then(v as _Identifier));

  @override
  _Identifier get _value => super._value as _Identifier;

  @override
  $Res call({
    Object? id = freezed,
    Object? extension = freezed,
    Object? use = freezed,
    Object? type = freezed,
    Object? system = freezed,
    Object? value = freezed,
    Object? period = freezed,
    Object? assigner = freezed,
  }) {
    return _then(_Identifier(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      extension: extension == freezed
          ? _value.extension
          : extension // ignore: cast_nullable_to_non_nullable
              as List<Extension>?,
      use: use == freezed
          ? _value.use
          : use // ignore: cast_nullable_to_non_nullable
              as IdentifierUseCode?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CodeableConcept<OpenimisIdentifiersCoding>?,
      system: system == freezed
          ? _value.system
          : system // ignore: cast_nullable_to_non_nullable
              as FhirUri?,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      period: period == freezed
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as Period?,
      assigner: assigner == freezed
          ? _value.assigner
          : assigner // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Identifier implements _Identifier {
  _$_Identifier(
      {this.id,
      this.extension,
      this.use,
      this.type,
      this.system,
      this.value,
      this.period,
      this.assigner});

  factory _$_Identifier.fromJson(Map<String, dynamic> json) =>
      _$$_IdentifierFromJson(json);

  @override
  final String? id;
  @override
  final List<Extension>? extension;
  @override
  final IdentifierUseCode? use;
  @override
  final CodeableConcept<OpenimisIdentifiersCoding>? type;
  @override
  final FhirUri? system;
  @override
  final String? value;
  @override
  final Period? period;
  @override
  final Reference? assigner;

  @override
  String toString() {
    return 'Identifier(id: $id, extension: $extension, use: $use, type: $type, system: $system, value: $value, period: $period, assigner: $assigner)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Identifier &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.extension, extension) &&
            const DeepCollectionEquality().equals(other.use, use) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.system, system) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.period, period) &&
            const DeepCollectionEquality().equals(other.assigner, assigner));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(extension),
      const DeepCollectionEquality().hash(use),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(system),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(period),
      const DeepCollectionEquality().hash(assigner));

  @JsonKey(ignore: true)
  @override
  _$IdentifierCopyWith<_Identifier> get copyWith =>
      __$IdentifierCopyWithImpl<_Identifier>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IdentifierToJson(this);
  }
}

abstract class _Identifier implements Identifier {
  factory _Identifier(
      {String? id,
      List<Extension>? extension,
      IdentifierUseCode? use,
      CodeableConcept<OpenimisIdentifiersCoding>? type,
      FhirUri? system,
      String? value,
      Period? period,
      Reference? assigner}) = _$_Identifier;

  factory _Identifier.fromJson(Map<String, dynamic> json) =
      _$_Identifier.fromJson;

  @override
  String? get id;
  @override
  List<Extension>? get extension;
  @override
  IdentifierUseCode? get use;
  @override
  CodeableConcept<OpenimisIdentifiersCoding>? get type;
  @override
  FhirUri? get system;
  @override
  String? get value;
  @override
  Period? get period;
  @override
  Reference? get assigner;
  @override
  @JsonKey(ignore: true)
  _$IdentifierCopyWith<_Identifier> get copyWith =>
      throw _privateConstructorUsedError;
}
