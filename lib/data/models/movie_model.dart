class Movie {
  String? title;
  String? year;
  List<String>? genre;
  String? plot;
  String? poster;
  String? imdbRating;
  String? type;
  String? id;

  Movie(
      {this.title,
      this.year,
      this.genre,
      this.plot,
      this.poster,
      this.imdbRating,
      this.type,
      this.id});

  Movie.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    year = json['Year'];
    genre = json['Genre'].cast<String>();
    plot = json['Plot'];
    poster = json['Poster'];
    imdbRating = json['imdbRating'];
    type = json['Type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Year'] = this.year;
    data['Genre'] = this.genre;
    data['Plot'] = this.plot;
    data['Poster'] = this.poster;
    data['imdbRating'] = this.imdbRating;
    data['Type'] = this.type;
    data['id'] = this.id;
    return data;
  }
}
