enum QuickLeave { AnnualLeave, SickLeave, EmergencyLeave, HalfDayLeave }

extension QuickLeaveProps on QuickLeave {
  String? get name {
    switch (this) {
      case QuickLeave.AnnualLeave:
        return "Annual Leave";
      case QuickLeave.EmergencyLeave:
        return "Emergency Leave";
      case QuickLeave.SickLeave:
        return "Sick Leave";
        case QuickLeave.HalfDayLeave:
        return "Half Day Leave";
      default:
        return null;
    }
  }
}
