

class Links {
  final String mission_patch;
  final String mission_patch_small;
  final String urlWikipedia;
  final List<dynamic> flikerImage;

  Links({
    this.mission_patch,
    this.mission_patch_small,
    this.urlWikipedia,
    this.flikerImage
  });

  factory Links.fromJson(Map<String, dynamic> json){
    List<dynamic> data = json['flickr_images'];

    return Links(
      mission_patch: json['mission_patch'],
      mission_patch_small: json['mission_patch_small'],
      urlWikipedia: json['wikipedia'],
      flikerImage: data.map((f)=>f).toList()
    );
  }
}