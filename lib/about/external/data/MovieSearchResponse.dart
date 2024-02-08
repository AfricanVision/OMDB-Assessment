import 'package:omdbassestment/about/external/data/safe_convert.dart';

import 'RatingsResponse.dart';

class MovieSearchResponse {
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;

  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final List<RatingsResponse> ratings;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbID;
  final String type;
  final String dVD;
  final String boxOffice;
  final String production;
  final String website;
  final String response;


  MovieSearchResponse({
    this.title = "",
    this.year = "",
    this.rated = "",
    this.released = "",
    this.runtime = "",
    this.genre = "",
    this.director = "",
    this.writer = "",
    this.actors = "",
    this.plot = "",
    this.language = "",
    this.country = "",
    this.awards = "",
    this.poster = "",
    required this.ratings,
    this.metascore = "",
    this.imdbRating = "",
    this.imdbVotes = "",
    this.imdbID = "",
    this.type = "",
    this.dVD = "",
    this.boxOffice = "",
    this.production = "",
    this.website = "",
    this.response = "",
  });

  factory MovieSearchResponse.fromJson(Map<String, dynamic>? json) => MovieSearchResponse(
    title: asString(json, 'Title'),
    year: asString(json, 'Year'),
    rated: asString(json, 'Rated'),
    released: asString(json, 'Released'),
    runtime: asString(json, 'Runtime'),
    genre: asString(json, 'Genre'),
    director: asString(json, 'Director'),
    writer: asString(json, 'Writer'),
    actors: asString(json, 'Actors'),
    plot: asString(json, 'Plot'),
    language: asString(json, 'Language'),
    country: asString(json, 'Country'),
    awards: asString(json, 'Awards'),
    poster: asString(json, 'Poster'),
    ratings: asList(json, 'Ratings').map((e) => RatingsResponse.fromJson(e)).toList(),
    metascore: asString(json, 'Metascore'),
    imdbRating: asString(json, 'imdbRating'),
    imdbVotes: asString(json, 'imdbVotes'),
    imdbID: asString(json, 'imdbID'),
    type: asString(json, 'Type'),
    dVD: asString(json, 'DVD'),
    boxOffice: asString(json, 'BoxOffice'),
    production: asString(json, 'Production'),
    website: asString(json, 'Website'),
    response: asString(json, 'Response'),
  );

  Map<String, dynamic> toJson() => {
    'Title': title,
    'Year': year,
    'Rated': rated,
    'Released': released,
    'Runtime': runtime,
    'Genre': genre,
    'Director': director,
    'Writer': writer,
    'Actors': actors,
    'Plot': plot,
    'Language': language,
    'Country': country,
    'Awards': awards,
    'Poster': poster,
    'Ratings': ratings.map((e) => e.toJson()).toList(),
    'Metascore': metascore,
    'imdbRating': imdbRating,
    'imdbVotes': imdbVotes,
    'imdbID': imdbID,
    'Type': type,
    'DVD': dVD,
    'BoxOffice': boxOffice,
    'Production': production,
    'Website': website,
    'Response': response,
  };
}


