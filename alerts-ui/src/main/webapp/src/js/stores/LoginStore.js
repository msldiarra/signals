import {LOGIN_USER, LOGOUT_USER} from '../constants/LoginConstants';
import BaseStore from './BaseStore';
import jwt_decode from 'jwt-decode';


class LoginStore extends BaseStore {

  constructor() {
    super();
    this.subscribe(() => this._registerToActions.bind(this))
    this._isLoggedIn = null;
  }

  _registerToActions(action) {
    switch(action.actionType) {
      case LOGIN_USER:;
        this._isLoggedIn = action.isLoggedIn;
        this.emitChange();
        break;
      case LOGOUT_USER:
        this._isLoggedIn = false;
        this._user = null;
        this.emitChange();
        break;
      default:
        break;
    };
  }

  get user() {
    return this._user;
  }

  isLoggedIn() {
    return this._isLoggedIn;
  }
}

export default new LoginStore();