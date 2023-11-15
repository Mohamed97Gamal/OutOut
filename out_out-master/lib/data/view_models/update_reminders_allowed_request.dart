class UpdateRemindersAllowedRequest {
  bool remindersAllowed;

  UpdateRemindersAllowedRequest(this.remindersAllowed);

  Map<String, dynamic> toJson() {
    return {
      'remindersAllowed': remindersAllowed,
    };
  }
}
