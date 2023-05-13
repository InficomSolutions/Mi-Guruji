class ChatHistoryModel {
  String? chat_id;
  String? receiver_token;
  String? sender_token;
  String? message;
  String? status;
  String? read_status;
  String? utc_date_time;
  String? created_at;
  String? attachment;
  bool? sent;
  ChatHistoryModel({
    this.utc_date_time,
    this.sender_token,
    this.receiver_token,
    this.read_status,
    this.chat_id,
    this.status,
    this.message,
    this.created_at,
    this.sent,
    this.attachment,
  });

  ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    chat_id = json['chat_id'];
    sender_token = json['sender_token'];
    receiver_token = json['receiver_token'];
    message = json['message'];
    status = json['status'];
    read_status = json['read_status'];
    utc_date_time = json['utc_date_time'];
    created_at = json['created_at'];
    attachment = json['attachment'];
    sent = false;
  }
  set setSent(val) => sent = val;
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['chat_id'] = chat_id!;
    json['sender_token'] = sender_token!;
    json['receiver_token'] = receiver_token!;
    json['message'] = message!;
    json['status'] = status!;
    json['read_status'] = read_status!;
    json['utc_date_time'] = utc_date_time!;
    json['created_at'] = created_at!;
    json['sent'] = sent;
    json['attachment'] = attachment;
    return json;
  }
}

class ChatModel {
  String? chat_id;
  String? sender_token;
  String? receiver_token;
  String? message;
  String? status;
  String? read_status;
  String? utc_date_time;
  String? created_at;
  String? date;
  String? time;
  bool? sent;

  ChatModel({
    this.message,
    this.status,
    this.chat_id,
    this.created_at,
    this.date,
    this.read_status,
    this.receiver_token,
    this.sender_token,
    this.time,
    this.utc_date_time,
    this.sent,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    chat_id = json['chat_id'];
    sender_token = json['sender_token'];
    receiver_token = json['receiver_token'];
    message = json['message'];
    status = json['status'];
    read_status = json['read_status'];
    utc_date_time = json['utc_date_time'];
    created_at = json['created_at'];
    // date = json['date'];
    // time = json['time'];
    sent = false;
  }

  set chatId(val) => chat_id = val;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['chat_id'] = chat_id!;
    json['sender_token'] = sender_token!;
    json['receiver_token'] = receiver_token!;
    json['message'] = message!;
    json['status'] = status!;
    json['read_status'] = read_status!;
    json['utc_date_time'] = utc_date_time!;
    json['created_at'] = created_at!;
    // json['date'] = date!;
    // json['time'] = time!;
    json['sent'] = sent;
    return json;
  }
}
