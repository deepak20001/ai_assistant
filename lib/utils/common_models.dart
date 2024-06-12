// import 'dart:convert';

// ///::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// ///:::::::::::::::::::::::::::: Content Model
// class ContentModel {
//   final List<ChatPartModel>? parts;
//   final String? role;

//   ContentModel({required this.parts, required this.role});

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'parts': parts?.map((x) => x.toMap()).toList(),
//       'role': role,
//     };
//   }

//   factory ContentModel.fromMap(Map<String, dynamic> map) {
//     return ContentModel(
//       parts: map['parts'] != null
//           ? List<ChatPartModel>.from(
//               (map['parts'] as List<int>).map<ChatPartModel?>(
//                 (x) => ChatPartModel.fromMap(x as Map<String, dynamic>),
//               ),
//             )
//           : null,
//       role: map['role'] != null ? map['role'] as String : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ContentModel.fromJson(String source) =>
//       ContentModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// // Chat Part Model
// class ChatPartModel {
//   final String? text;

//   ChatPartModel({required this.text});

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'text': text,
//     };
//   }

//   factory ChatPartModel.fromMap(Map<String, dynamic> map) {
//     return ChatPartModel(
//       text: map['text'] != null ? map['text'] as String : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ChatPartModel.fromJson(String source) =>
//       ChatPartModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }
