// enumerations types

// +++ StageCard
enum StageCard {
  story,
  todo,
  doing,
  check,
  done,
}

extension StageCardExtension on StageCard {
  static const names = {
    StageCard.story: 'Pendências',
    StageCard.todo: 'Para fazer',
    StageCard.doing: 'Fazendo',
    StageCard.check: 'Verificando',
    StageCard.done: 'Concluído',
  };

  String get name => names[this];
}

//---StageCard
//class types

class Team {
  String id;
  String displayName;
  String photoUrl;
  bool readedCard;

  Team({
    this.id,
    this.displayName,
    this.photoUrl,
    this.readedCard,
  });
  Team.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('id')) id = map['id'];
    if (map.containsKey('displayName')) displayName = map['displayName'];
    if (map.containsKey('photoUrl')) photoUrl = map['photoUrl'];
    if (map.containsKey('readedCard')) readedCard = map['readedCard'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) data['id'] = this.id;
    if (displayName != null) data['displayName'] = this.displayName;
    if (photoUrl != null) data['photoUrl'] = this.photoUrl;
    if (readedCard != null) data['readedCard'] = this.readedCard;
    return data;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      displayName.hashCode ^
      photoUrl.hashCode ^
      readedCard.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Team &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          displayName == other.displayName &&
          photoUrl == other.photoUrl &&
          readedCard == other.readedCard;
}

class Todo {
  String id;
  String title;
  bool complete;

  Todo({
    this.id,
    this.title,
    this.complete,
  });
  Todo.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('title')) title = map['title'];
    if (map.containsKey('complete')) complete = map['complete'];
    if (map.containsKey('id')) id = map['id'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (title != null) data['title'] = this.title;
    if (complete != null) data['complete'] = this.complete;
    if (id != null) data['id'] = this.id;
    return data;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ complete.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          id == other.id &&
          title == other.title &&
          complete == other.complete;
}

class Feed {
  Team author;
  String description;
  String link;
  dynamic created;
  String id;
  bool bot;

  Feed({
    this.description,
    this.author,
    this.link,
    this.id,
    this.bot,
  });
  Feed.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('description')) description = map['description'];
    created = (map.containsKey('created') && map['created'] != null)
        ? DateTime.fromMillisecondsSinceEpoch(
            map['created'].millisecondsSinceEpoch)
        : null;
    author = map.containsKey('author') && map['author'] != null
        ? Team.fromMap(map['author'])
        : null;
    if (map.containsKey('link')) link = map['link'];
    if (map.containsKey('id')) id = map['id'];
    if (map.containsKey('bot')) bot = map['bot'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (description != null) data['description'] = this.description;
    if (created != null) data['created'] = this.created;
    if (link != null) data['link'] = this.link;
    if (id != null) data['id'] = this.id;
    if (bot != null) data['bot'] = this.bot;
    if (this.author != null) {
      data['author'] = this.author.toMap();
    }
    return data;
  }

  @override
  int get hashCode =>
      author.hashCode ^
      description.hashCode ^
      link.hashCode ^
      created.hashCode ^
      id.hashCode ^
      bot.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Feed &&
          author == other.author &&
          description == other.description &&
          link == other.link &&
          created == other.created &&
          id == other.id &&
          bot == other.bot;
}
