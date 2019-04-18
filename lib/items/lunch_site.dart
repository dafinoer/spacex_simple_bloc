

class LunchSite {
  final String siteId;
  final String siteName;
  final String siteNameLong;

  LunchSite({
    this.siteId,
    this.siteName,
    this.siteNameLong
});

  factory LunchSite.fromJson(Map<String, dynamic> json){
   return LunchSite(
     siteId: json['site_id'],
     siteName: json['site_name'],
     siteNameLong: json['site_name_long']
   );
  }
}