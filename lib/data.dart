List<String> comboboxtype = [];
List<String> comboboxproduct = [];
List<Pilihan> listNmtype = <Pilihan>[];
List<RecordData> listrecord = <RecordData>[];

class Pilihan {
  String Nmtype;
  Pilihan(this.Nmtype);
}

class RecordData {
  String date;
  String value;
  String type;
  String product;
  RecordData(this.date, this.value, this.type, this.product);
}

var baseurl = "http://apirecordinvest.herokuapp.com/";
