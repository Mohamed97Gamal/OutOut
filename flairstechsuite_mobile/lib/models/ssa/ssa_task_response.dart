class SSATaskResponse {
  String? id;
  int? readableId;
  String? createdDate;
  String? lastModifiedDate;
  int? workflowType;
  String? workflowTypeName;
  Issuer? issuer;
  Issuer? targetEmployee;
  String? taskName;
  TaskNotes? taskNotes;
  int? currentStateType;
  String? taskStatus;
  List<AvailableChoices>? availableChoices;
  SubmittedChoice? submittedChoice;

  SSATaskResponse({
    this.id,
    this.readableId,
    this.createdDate,
    this.lastModifiedDate,
    this.workflowType,
    this.workflowTypeName,
    this.issuer,
    this.targetEmployee,
    this.taskName,
    this.taskNotes,
    this.currentStateType,
    this.taskStatus,
    this.availableChoices,
    this.submittedChoice,
  });

  SSATaskResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readableId = json['readableId'];
    createdDate = json['createdDate'];
    lastModifiedDate = json['lastModifiedDate'];
    workflowType = json['workflowType'];
    workflowTypeName = json['workflowTypeName'];
    issuer = json['issuer'] != null ? Issuer.fromJson(json['issuer']) : null;
    targetEmployee = json['targetEmployee'] != null ? Issuer.fromJson(json['targetEmployee']) : null;
    taskName = json['taskName'];
    taskNotes = json['taskNotes'] != null ? TaskNotes.fromJson(json['taskNotes']) : null;
    currentStateType = json['currentStateType'];
    taskStatus = json['taskStatus'];
    if (json['availableChoices'] != null) {
      availableChoices = <AvailableChoices>[];
      json['availableChoices'].forEach((v) {
        availableChoices!.add(AvailableChoices.fromJson(v));
      });
    }
    submittedChoice = json['submittedChoice'] != null ? SubmittedChoice.fromJson(json['submittedChoice']) : null;
  }
}

class Issuer {
  String? fullName;
  String? organizationEmail;

  Issuer({this.fullName, this.organizationEmail});

  Issuer.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    organizationEmail = json['organizationEmail'];
  }
}

class TaskNotes {
  int? priority;
  String? note;

  TaskNotes({this.priority, this.note});

  TaskNotes.fromJson(Map<String, dynamic> json) {
    priority = json['priority'];
    note = json['note'];
  }
}

class AvailableChoices {
  String? displayName;
  String? identifier;
  int? type;
  String? icon;
  SubmittedChoice? submittedChoice;

  AvailableChoices({this.displayName, this.identifier, this.type, this.icon, this.submittedChoice});

  AvailableChoices.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    identifier = json['identifier'];
    type = json['type'];
    icon = json['icon'];
    submittedChoice = json['submittedChoice'] != null ? SubmittedChoice.fromJson(json['submittedChoice']) : null;
  }
}

class SubmittedChoice {
  String? action;
  String? cssClass;

  SubmittedChoice({this.action, this.cssClass});

  SubmittedChoice.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    cssClass = json['cssClass'];
  }
}

class SSATaskResponsePage {
  int? nextPage;
  int? pageNumber;
  int? previousPage;
  int? pageSize;
  int? recordsTotalCount;
  int? totalPages;
  List<SSATaskResponse>? records;

  SSATaskResponsePage({
    this.nextPage,
    this.pageNumber,
    this.previousPage,
    this.pageSize,
    this.recordsTotalCount,
    this.totalPages,
    this.records,
  });

  SSATaskResponsePage.fromJson(Map<String, dynamic> json) {
    nextPage = json['nextPage'];
    pageNumber = json['pageNumber'];
    previousPage = json['previousPage'];
    pageSize = json['pageSize'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    if (json['records'] != null) {
      records = <SSATaskResponse>[];
      json['records'].forEach((v) {
        records!.add(SSATaskResponse.fromJson(v));
      });
    }
  }
}

class TaskResponsePageOperationResult {
  bool? status;
  SSATaskResponsePage? result;
  int? errorCode;
  String? errorMessage;
  List<String>? errors;

  TaskResponsePageOperationResult({this.status, this.result, this.errorCode, this.errorMessage, this.errors});

  TaskResponsePageOperationResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'] != null ? SSATaskResponsePage.fromJson(json['result']) : null;
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = json['errors'].cast<String>();
  }
}
