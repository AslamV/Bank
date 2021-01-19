class CustomerData {
  int account_no;
  String cust_name;
  String cust_addr;
  int phone_no;
  double bal;

  CustomerData(
      this.account_no, this.cust_name, this.cust_addr, this.phone_no, this.bal);

//Getters
  int get accountNo => account_no;
  String get custName => cust_name;
  String get custAddr => cust_addr;
  int get phoneNo => phone_no;
  double get balance => bal;

//Setters
  set accountNo(int accountNo) {
    this.account_no = accountNo;
  }

  set custName(String newnote) {
    this.cust_name = cust_name;
  }

  set custAddr(String custAddr) {
    this.cust_addr = custAddr;
  }

  set phoneNo(int phoneNo) {
    this.phone_no = phoneNo;
  }

  set balance(double bal) {
    this.bal = bal;
  }

// convert obj to map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (account_no != null) {
      map['account_no'] = account_no;
    }

    map['cust_name'] = cust_name;
    map['cust_addr'] = cust_addr;
    map['phone_no'] = phone_no;
    map['bal'] = bal;

    return map;
  }

  //Exract CustomerData obj from map obj
  CustomerData.fromMapObject(Map<String, dynamic> map) {
    this.account_no = map['account_no'];
    this.cust_name = map['cust_name'];
    this.cust_addr = map['cust_addr'];
    this.phone_no = map['phone_no'];
    this.bal = map['bal'];
  }
} //End of cla
