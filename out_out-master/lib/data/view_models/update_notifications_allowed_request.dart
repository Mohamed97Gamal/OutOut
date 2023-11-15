class UpdateNotificationsAllowedRequest {
  bool notificationsAllowed;

  UpdateNotificationsAllowedRequest(this.notificationsAllowed);

  Map<String, dynamic> toJson() {
    return {
      'notificationsAllowed': notificationsAllowed,
    };
  }
}
