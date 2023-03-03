class UsDataResponse {
  List<Data>? udata;
  List<Source>? source;

  UsDataResponse({this.udata, this.source});

  UsDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      udata = <Data>[];
      json['data'].forEach((v) {
        udata!.add(new Data.fromJson(v));
      });
    }
    if (json['source'] != null) {
      source = <Source>[];
      json['source'].forEach((v) {
        source!.add(new Source.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.udata != null) {
      data['data'] = this.udata!.map((v) => v.toJson()).toList();
    }
    if (this.source != null) {
      data['source'] = this.source!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? iDNation;
  String? nation;
  int? iDYear;
  String? year;
  int? population;
  String? slugNation;

  Data(
      {this.iDNation,
      this.nation,
      this.iDYear,
      this.year,
      this.population,
      this.slugNation});

  Data.fromJson(Map<String, dynamic> json) {
    iDNation = json['ID Nation'];
    nation = json['Nation'];
    iDYear = json['ID Year'];
    year = json['Year'];
    population = json['Population'];
    slugNation = json['Slug Nation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID Nation'] = this.iDNation;
    data['Nation'] = this.nation;
    data['ID Year'] = this.iDYear;
    data['Year'] = this.year;
    data['Population'] = this.population;
    data['Slug Nation'] = this.slugNation;
    return data;
  }
}

class Source {
  List<String>? measures;
  Annotations? annotations;
  
  Source({this.measures, this.annotations,  });

  Source.fromJson(Map<String, dynamic> json) {
    measures = json['measures'].cast<String>();
    annotations = json['annotations'] != null
        ? new Annotations.fromJson(json['annotations'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['measures'] = this.measures;
    if (this.annotations != null) {
      data['annotations'] = this.annotations!.toJson();
    }
    return data;
  }
}

class Annotations {
  String? sourceName;
  String? datasetLink;

  Annotations({
    this.sourceName,
    this.datasetLink,
  });

  Annotations.fromJson(Map<String, dynamic> json) {
    sourceName = json['source_name'];
    datasetLink = json['dataset_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source_name'] = this.sourceName;
    data['dataset_link'] = this.datasetLink;

    return data;
  }
}

