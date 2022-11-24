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

var Build = "1";
var Major = "1";
var Minor = "0";

var saldoglobal = 0.0;
var devurl = "http://127.0.0.1:5000/";
var profurl = "http://apirecordinvest.herokuapp.com/";

var baseurl = profurl;
