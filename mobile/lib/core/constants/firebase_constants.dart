class FirebaseConstants {
  FirebaseConstants._();

  // Collection names (match database schema)
  static const String usersCollection = 'users';
  static const String ofwProfilesCollection = 'ofw_profiles';
  static const String organizationProfilesCollection = 'organization_profiles';
  static const String contractsCollection = 'contracts';
  static const String contractAnalysisCollection = 'contract_analysis';
  static const String contractReviewsCollection = 'contract_reviews';
  static const String jobOffersCollection = 'job_offers';
  static const String communityPostsCollection = 'community_posts';
  static const String postCommentsCollection = 'post_comments';
  static const String notificationsCollection = 'notifications';
  static const String reportsCollection = 'reports';
  static const String aiUsageLogsCollection = 'ai_usage_logs';

  // Wage monitoring – stored as a sub-collection under each user document.
  static const String wageLogsSubcollection = 'wage_logs';
}
