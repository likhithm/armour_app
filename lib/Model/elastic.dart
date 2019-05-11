class Elastic {
  int took;
  bool timedOut;
  Shards sShards;
  Hits hits;

  Elastic({this.took, this.timedOut, this.sShards, this.hits});

  Elastic.fromJson(Map<String, dynamic> json) {
    took = json['took'];
    timedOut = json['timed_out'];
    sShards =
    json['_shards'] != null ? new Shards.fromJson(json['_shards']) : null;
    hits = json['hits'] != null ? new Hits.fromJson(json['hits']) : null;
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['took'] = this.took;
    data['timed_out'] = this.timedOut;
    if (this.sShards != null) {
      data['_shards'] = this.sShards.toJson();
    }
    if (this.hits != null) {
      data['hits'] = this.hits.toJson();
    }
    return data;
  }*/
}

class Shards {
  int total;
  int successful;
  int skipped;
  int failed;

  Shards({this.total, this.successful, this.skipped, this.failed});

  Shards.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    successful = json['successful'];
    skipped = json['skipped'];
    failed = json['failed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['successful'] = this.successful;
    data['skipped'] = this.skipped;
    data['failed'] = this.failed;
    return data;
  }
}

class Hits {
  int total;
  double maxScore;
  List<Hits> hits;

  Hits({this.total, this.maxScore, this.hits});

  Hits.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    maxScore = json['max_score'];
    if (json['hits'] != null) {
      hits = new List<Hits>();
      json['hits'].forEach((v) {
        hits.add(new Hits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['max_score'] = this.maxScore;
    if (this.hits != null) {
      data['hits'] = this.hits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hit {
  String sIndex;
  String sType;
  String sId;
  double dScore;
  Source sSource;

  Hit({this.sIndex, this.sType, this.sId, this.dScore, this.sSource});

  Hit.fromJson(Map<String, dynamic> json) {
    sIndex = json['_index'];
    sType = json['_type'];
    sId = json['_id'];
    dScore = json['_score'];
    sSource =
    json['_source'] != null ? new Source.fromJson(json['_source']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_index'] = this.sIndex;
    data['_type'] = this.sType;
    data['_id'] = this.sId;
    data['_score'] = this.dScore;
    if (this.sSource != null) {
      data['_source'] = this.sSource.toJson();
    }
    return data;
  }
}

class Source {
  int id;
  String firstName;
  String lastName;
  String email;
  String gender;
  String ipAddress;

  Source(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.gender,
        this.ipAddress});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    gender = json['gender'];
    ipAddress = json['ip_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['ip_address'] = this.ipAddress;
    return data;
  }
}