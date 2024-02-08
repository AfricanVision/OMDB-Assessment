

class Test {
  String Title;
  String Year;
  String Rated;
  String Released;
  String Runtime;
  String Genre;
  String Director;
  String Writer;
  String Actors;
  String Plot;
  String Language;
  String Country;
  String Awards;
  String Poster;
  List<RatingsItem>? Ratings;
  String Metascore;
  String imdbRating;
  String imdbVotes;
  String imdbID;
  String Type;
  String DVD;
  String BoxOffice;
  String Production;
  String Website;
  String Response;

  Test({
    this.Title = "",
    this.Year = "",
    this.Rated = "",
    this.Released = "",
    this.Runtime = "",
    this.Genre = "",
    this.Director = "",
    this.Writer = "",
    this.Actors = "",
    this.Plot = "",
    this.Language = "",
    this.Country = "",
    this.Awards = "",
    this.Poster = "",
    this.Ratings,
    this.Metascore = "",
    this.imdbRating = "",
    this.imdbVotes = "",
    this.imdbID = "",
    this.Type = "",
    this.DVD = "",
    this.BoxOffice = "",
    this.Production = "",
    this.Website = "",
    this.Response = "",
  });

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    Title: json['Title'],
    Year: json['Year'],
    Rated: json['Rated'],
    Released: json['Released'],
    Runtime: json['Runtime'],
    Genre: json['Genre'],
    Director: json['Director'],
    Writer: json['Writer'],
    Actors: json['Actors'],
    Plot: json['Plot'],
    Language: json['Language'],
    Country: json['Country'],
    Awards: json['Awards'],
    Poster: json['Poster'],
    Ratings: json['Ratings']?.map((e) => RatingsItem.fromJson(e))?.toList(),
    Metascore: json['Metascore'],
    imdbRating: json['imdbRating'],
    imdbVotes: json['imdbVotes'],
    imdbID: json['imdbID'],
    Type: json['Type'],
    DVD: json['DVD'],
    BoxOffice: json['BoxOffice'],
    Production: json['Production'],
    Website: json['Website'],
    Response: json['Response'],
  );

  Map<String, dynamic> toJson() => {
    'Title': Title,
    'Year': Year,
    'Rated': Rated,
    'Released': Released,
    'Runtime': Runtime,
    'Genre': Genre,
    'Director': Director,
    'Writer': Writer,
    'Actors': Actors,
    'Plot': Plot,
    'Language': Language,
    'Country': Country,
    'Awards': Awards,
    'Poster': Poster,
    'Ratings': (Ratings ?? []).map((e) => e.toJson()).toList(),
    'Metascore': Metascore,
    'imdbRating': imdbRating,
    'imdbVotes': imdbVotes,
    'imdbID': imdbID,
    'Type': Type,
    'DVD': DVD,
    'BoxOffice': BoxOffice,
    'Production': Production,
    'Website': Website,
    'Response': Response,
  };
}

class RatingsItem {
  String Source;
  String Value;

  RatingsItem({
    this.Source = "",
    this.Value = "",
  });

  factory RatingsItem.fromJson(Map<String, dynamic> json) => RatingsItem(
    Source: json['Source'],
    Value: json['Value'],
  );

  Map<String, dynamic> toJson() => {
    'Source': Source,
    'Value': Value,
  };
}

