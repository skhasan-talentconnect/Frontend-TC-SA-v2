enum DetailTabEnum {
  overview,
  academics,
  facultyDetails,
  infrastructure,
  techAdaption,
  activities,
  safetySecurity,
  internationalExposure,
  feesAndScholarship,
  admissionTimeline,
  amenities,
  aluminis,
  reviews,
  otherDetails,
  photos,
}

extension DetailTabEnumExtension on DetailTabEnum {
  String get label {
    switch (this) {
      case DetailTabEnum.overview:
        return 'Overview';
      case DetailTabEnum.academics:
        return 'Academics';
      case DetailTabEnum.facultyDetails:
        return 'Faculty Details';
      case DetailTabEnum.infrastructure:
        return 'Infrastructure';
      case DetailTabEnum.techAdaption:
        return 'Tech Adaption';
      case DetailTabEnum.activities:
        return 'Activities';
      case DetailTabEnum.safetySecurity:
        return 'Safety & Security';
      case DetailTabEnum.internationalExposure:
        return 'International Exposure';
      case DetailTabEnum.feesAndScholarship:
        return 'Fees & Scholarship';
      case DetailTabEnum.admissionTimeline:
        return 'Admission Timeline';
      case DetailTabEnum.amenities:
        return 'Amenities';
      case DetailTabEnum.aluminis:
        return 'Aluminis';
      case DetailTabEnum.reviews:
        return 'Reviews';
      case DetailTabEnum.otherDetails:
        return 'Gender Distribution';
      case DetailTabEnum.photos:
       return 'Media';
    }
  }
}
