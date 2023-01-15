List<String> comboboxtype = [];
List<String> comboboxproduct = [];
List<Pilihan> listNmtype = <Pilihan>[];
List<RecordData> listrecord = <RecordData>[];
List<ComboBoxData> list_cb_data = <ComboBoxData>[];
List<String> combobox = [];

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

class ComboBoxData {
  String date;
  String product;
  String value;
  ComboBoxData(this.date, this.value, this.product);
}

var Build = "1";
var Major = "1";
var Minor = "0";

var saldoglobal = 0.0;
var devurl = "http://127.0.0.1:5000/";
// var profurl = "http://apirecordinvest.herokuapp.com/";
var profurl = "http://dafageraldine.pythonanywhere.com/";

var baseurl = profurl;
