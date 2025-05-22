import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';


@freezed
class User with _$User {
   factory User({@Default('') String name, }) = _User;

   factory User.fromJson(Map<String,dynamic>json)=> _$UserFromJson(json);

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
  }
