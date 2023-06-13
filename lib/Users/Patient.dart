class User {

  dynamic uname,pass;

  User(this.uname, this.pass);

  getId() {
    return uname;
  }

  setId(uname) {
    this.uname = uname;
  }

  getPass() {
    return pass;
  }
}