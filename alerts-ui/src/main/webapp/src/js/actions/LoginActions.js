import AppDispatcher from '../dispatchers/AppDispatcher.js';
import {LOGIN_USER, LOGOUT_USER} from '../constants/LoginConstants.js';
import RouterContainer from '../services/RouterContainer.js';

export default {

  loginUser: (isLoggedIn) => {

    var nextPath =  null;

    if (RouterContainer.get().getCurrentQuery()) {
      var nextPath = RouterContainer.get().getCurrentQuery().nextPath || '/';
    }

    if(nextPath) {
        RouterContainer.get().transitionTo(nextPath);
    }

    localStorage.setItem('isUserLoggedIn', true);

    AppDispatcher.dispatch({
      actionType: LOGIN_USER,
      isLoggedIn: isLoggedIn
    });
  },


  logoutUser: () => {

    RouterContainer.get().transitionTo('/login');
    localStorage.removeItem('isUserLoggedIn');

    AppDispatcher.dispatch({
      actionType: LOGOUT_USER
    });
  }

}