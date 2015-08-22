import AppDispatcher from '../dispatchers/AppDispatcher.js';
import {LOGIN_USER, LOGOUT_USER} from '../constants/LoginConstants.js';
import RouterContainer from '../services/RouterContainer.js'

export default {

  loginUser: () => {
    var nextPath = RouterContainer.get().getCurrentQuery().nextPath || '/';
    RouterContainer.get().transitionTo(nextPath);
  }

    AppDispatcher.dispatch({
      actionType: LOGIN_USER
    });
  },


  logoutUser: () => {

    RouterContainer.get().transitionTo('/login');
    AppDispatcher.dispatch({
      actionType: LOGOUT_USER
    });
  }

}