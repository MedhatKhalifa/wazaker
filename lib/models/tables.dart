class Azkar {
  int _id;
  String _category, _pre, _content, _after, _fadl;
  int _hours, _totalCount, _currentCount;
  String _startDate, _endDate;

  // DateFormat.yMd().parse('06/09/2019');

  Azkar(dynamic obj) {
    _id = obj['id'];
    _category = obj['category'];
    _content = obj['content'];
    _hours = obj['hours'];
    _pre = obj['pre'];
    _after = obj['after'];
    _totalCount = obj['totalCount'];
    _currentCount = obj['currentCount'];
    _startDate = obj['startDate'];
    _endDate = obj['endDate'];
    _fadl = obj['fadl'];
  }
  Azkar.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _category = data['category'];
    _content = data['content'];
    _hours = data['hours'];
    _pre = data['pre'];
    _after = data['after'];
    _totalCount = data['totalCount'];
    _currentCount = data['currentCount'];
    _startDate = data['startDate'];
    _endDate = data['endDate'];
    _fadl = data['fadl'];
  }
  Map<String, dynamic> toMap() => {
        'id': _id,
        'category': _category,
        'content': _content,
        'hours': _hours,
        'pre': _pre,
        'after': _after,
        'totalCount': _totalCount,
        'currentCount': _currentCount,
        'startDate': _startDate,
        'endDate': _endDate,
        'fadl': _fadl
      };
  int get id => _id;
  String get category => _category;
  String get content => _content;
  int get hours => _hours;
  String get pre => _pre;
  int get totalCount => _totalCount;
  String get after => _after;
  int get currentCount => _currentCount;
  String get startDate => _startDate;
  String get endDate => _endDate;
  String get fadl => _fadl;

  void set currenttotal(int curentt) {
    _currentCount = curentt;
  }

  void set totaltotal(int totalt) {
    _totalCount = totalt;
  }
}
