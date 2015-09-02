import AppDispatcher from '../dispatchers/AppDispatcher.js';
import {LOGIN_USER, LOGOUT_USER} from '../constants/LoginConstants.js';
import RouterContainer from '../services/RouterContainer.js';

export default {

  loginUser: (user) => {

    var savedUser = localStorage.getItem('user');

    console.log(savedUser);
    console.log(user);

    if (savedUser !== user) {

      var nextPath = RouterContainer.get().getCurrentQuery().nextPath || '/';

      RouterContainer.get().transitionTo(nextPath);
      localStorage.setItem('user', user);
    }

    AppDispatcher.dispatch({
      actionType: LOGIN_USER,
      user: user
    });
  },


  logoutUser: () => {

    RouterContainer.get().transitionTo('/login');
    localStorage.removeItem('user');

    AppDispatcher.dispatch({
      actionType: LOGOUT_USER
    });
  }

}