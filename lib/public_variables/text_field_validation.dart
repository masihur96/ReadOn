
bool nameValidation(String name) {
  if(name != ''){
    return true;
  }else{
    return false;
  }
}

bool emailValidation(String email) {
  if(email != '' && email.contains('@') && email.contains('.com')){
    return true;
  }else{
    return false;
  }
}

bool phoneNoValidation(String phoneNo) {
  if(phoneNo != '' && phoneNo.length == 11) {
    return true;
  }
  else{
    return false;
  }
}

bool passWordValidation(String password) {
  if(password != '' && password.length >= 8) {
    return true;
  }
  else{
    return false;
  }
}

bool confirmPasswordValidation(String password, String confirmPassword) {
  if(password == confirmPassword) {
    return true;
  }else{
    return false;
  }
}
