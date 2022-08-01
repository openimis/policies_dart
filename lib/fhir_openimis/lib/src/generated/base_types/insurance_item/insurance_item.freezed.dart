// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'insurance_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InsuranceItem _$InsuranceItemFromJson(Map<String, dynamic> json) {
  return _InsuranceItem.fromJson(json);
}

/// @nodoc
class _$InsuranceItemTearOff {
  const _$InsuranceItemTearOff();

  _InsuranceItem call(
      {String? id,
      List<Extension>? extension,
      CodeableConcept<dynamic>? category,
      String? name,
      String? description,
      CodeableConcept<dynamic>? productOrService,
      Boolean? excluded,
      List<BackboneElement>? benefit}) {
    return _InsuranceItem(
      id: id,
      extension: extension,
      category: category,
      name: name,
      description: description,
      productOrService: productOrService,
      excluded: excluded,
      benefit: benefit,
    );
  }

  InsuranceItem fromJson(Map<String, Object?> json) {
    return InsuranceItem.fromJson(json);
  }
}

/// @nodoc
const $InsuranceItem = _$InsuranceItemTearOff();

/// @nodoc
mixin _$InsuranceItem {
  String? get id => throw _privateConstructorUsedError;
  List<Extension>? get extension => throw _privateConstructorUsedError;
  CodeableConcept<dynamic>? get category => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  CodeableConcept<dynamic>? get productOrService =>
      throw _privateConstructorUsedError;
  Boolean? get excluded => throw _privateConstructorUsedError;
  List<BackboneElement>? get benefit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InsuranceItemCopyWith<InsuranceItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsuranceItemCopyWith<$Res> {
  factory $InsuranceItemCopyWith(
          InsuranceItem value, $Res Function(InsuranceItem) then) =
      _$InsuranceItemCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      List<Extension>? extension,
      CodeableConcept<dynamic>? category,
      String? name,
      String? description,
      CodeableConcept<dynamic>? productOrService,
      Boolean? excluded,
      List<BackboneElement>? benefit});

  $CodeableConceptCopyWith<dynamic, $Res>? get category;
  $CodeableConceptCopyWith<dynamic, $Res>? get productOrService;
}

/// @nodoc
class _$InsuranceItemCopyWithImpl<$Res>
    implements $InsuranceItemCopyWith<$Res> {
  _$InsuranceItemCopyWithImpl(this._value, this._then);

  final InsuranceItem _value;
  // ignore: unused_field
  final $Res Function(InsuranceItem) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? extension = freezed,
    Object? category = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? productOrService = freezed,
    Object? excluded = freezed,
    Object? benefit = freezed,
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
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept<dynamic>?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      productOrService: productOrService == freezed
          ? _value.productOrService
          : productOrService // ignore: cast_nullable_to_non_nullable
              as CodeableConcept<dynamic>?,
      excluded: excluded == freezed
          ? _value.excluded
          : excluded // ignore: cast_nullable_to_non_nullable
              as Boolean?,
      benefit: benefit == freezed
          ? _value.benefit
          : benefit // ignore: cast_nullable_to_non_nullable
              as List<BackboneElement>?,
    ));
  }

  @override
  $CodeableConceptCopyWith<dynamic, $Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CodeableConceptCopyWith<dynamic, $Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value));
    });
  }

  @override
  $CodeableConceptCopyWith<dynamic, $Res>? get productOrService {
    if (_value.productOrService == null) {
      return null;
    }

    return $CodeableConceptCopyWith<dynamic, $Res>(_value.productOrService!,
        (value) {
      return _then(_value.copyWith(productOrService: value));
    });
  }
}

/// @nodoc
abstract class _$InsuranceItemCopyWith<$Res>
    implements $InsuranceItemCopyWith<$Res> {
  factory _$InsuranceItemCopyWith(
          _InsuranceItem value, $Res Function(_InsuranceItem) then) =
      __$InsuranceItemCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      List<Extension>? extension,
      CodeableConcept<dynamic>? category,
      String? name,
      String? description,
      CodeableConcept<dynamic>? productOrService,
      Boolean? excluded,
      List<BackboneElement>? benefit});

  @override
  $CodeableConceptCopyWith<dynamic, $Res>? get category;
  @override
  $CodeableConceptCopyWith<dynamic, $Res>? get productOrService;
}

/// @nodoc
class __$InsuranceItemCopyWithImpl<$Res>
    extends _$InsuranceItemCopyWithImpl<$Res>
    implements _$InsuranceItemCopyWith<$Res> {
  __$InsuranceItemCopyWithImpl(
      _InsuranceItem _value, $Res Function(_InsuranceItem) _then)
      : super(_value, (v) => _then(v as _InsuranceItem));

  @override
  _InsuranceItem get _value => super._value as _InsuranceItem;

  @override
  $Res call({
    Object? id = freezed,
    Object? extension = freezed,
    Object? category = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? productOrService = freezed,
    Object? excluded = freezed,
    Object? benefit = freezed,
  }) {
    return _then(_InsuranceItem(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      extension: extension == freezed
          ? _value.extension
          : extension // ignore: cast_nullable_to_non_nullable
              as List<Extension>?,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept<dynamic>?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      productOrService: productOrService == freezed
          ? _value.productOrService
          : productOrService // ignore: cast_nullable_to_non_nullable
              as CodeableConcept<dynamic>?,
      excluded: excluded == freezed
          ? _value.excluded
          : excluded // ignore: cast_nullable_to_non_nullable
              as Boolean?,
      benefit: benefit == freezed
          ? _value.benefit
          : benefit // ignore: cast_nullable_to_non_nullable
              as List<BackboneElement>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InsuranceItem implements _InsuranceItem {
  _$_InsuranceItem(
      {this.id,
      this.extension,
      this.category,
      this.name,
      this.description,
      this.productOrService,
      this.excluded,
      this.benefit});

  factory _$_InsuranceItem.fromJson(Map<String, dynamic> json) =>
      _$$_InsuranceItemFromJson(json);

  @override
  final String? id;
  @override
  final List<Extension>? extension;
  @override
  final CodeableConcept<dynamic>? category;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final CodeableConcept<dynamic>? productOrService;
  @override
  final Boolean? excluded;
  @override
  final List<BackboneElement>? benefit;

  @override
  String toString() {
    return 'InsuranceItem(id: $id, extension: $extension, category: $category, name: $name, description: $description, productOrService: $productOrService, excluded: $excluded, benefit: $benefit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InsuranceItem &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.extension, extension) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.productOrService, productOrService) &&
            const DeepCollectionEquality().equals(other.excluded, excluded) &&
            const DeepCollectionEquality().equals(other.benefit, benefit));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(extension),
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(productOrService),
      const DeepCollectionEquality().hash(excluded),
      const DeepCollectionEquality().hash(benefit));

  @JsonKey(ignore: true)
  @override
  _$InsuranceItemCopyWith<_InsuranceItem> get copyWith =>
      __$InsuranceItemCopyWithImpl<_InsuranceItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InsuranceItemToJson(this);
  }
}

abstract class _InsuranceItem implements InsuranceItem {
  factory _InsuranceItem(
      {String? id,
      List<Extension>? extension,
      CodeableConcept<dynamic>? category,
      String? name,
      String? description,
      CodeableConcept<dynamic>? productOrService,
      Boolean? excluded,
      List<BackboneElement>? benefit}) = _$_InsuranceItem;

  factory _InsuranceItem.fromJson(Map<String, dynamic> json) =
      _$_InsuranceItem.fromJson;

  @override
  String? get id;
  @override
  List<Extension>? get extension;
  @override
  CodeableConcept<dynamic>? get category;
  @override
  String? get name;
  @override
  String? get description;
  @override
  CodeableConcept<dynamic>? get productOrService;
  @override
  Boolean? get excluded;
  @override
  List<BackboneElement>? get benefit;
  @override
  @JsonKey(ignore: true)
  _$InsuranceItemCopyWith<_InsuranceItem> get copyWith =>
      throw _privateConstructorUsedError;
}
