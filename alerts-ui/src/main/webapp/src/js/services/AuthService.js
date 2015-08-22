import request from 'reqwest';
import when from 'when';
import {LOGIN_URL, SIGNUP_URL} from '../constants/LoginConstants';
import LoginActions from '../actions/LoginActions';

class AuthService {

  login(username, password) {

    var encoded = new Buffer(username + ':' + password, 'base64');

    return this.handleAuth(when(request({
      url: LOGIN_URL,
      method: 'POST',
      crossOrigin: true,
      type: 'json',
      headers: {
            'Authorization' : 'Basic ' + encoded
      }
    })));
  }

  logout() {
    LoginActions.logoutUser();
  }

  signup(username, password, extra) {
    return this.handleAuth(when(request({
      url: SIGNUP_URL,
      method: 'POST',
      crossOrigin: true,
      type: 'json',
      data: {
        username, password, extra
      }
    })));
  }

  handleAuth(loginPromise) {
    return loginPromise
      .then(function(response) {
        LoginActions.loginUser();
        return true;
      });
  }
}

export default new AuthService()