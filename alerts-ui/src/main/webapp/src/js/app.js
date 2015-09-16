import React from 'react';
import Router, {Route} from 'react-router';
import RouterContainer from './services/RouterContainer';
import AuthenticatedApp from './components/AuthenticatedApp';
import Login from './components/Login';
import Home from './components/Home';
import Signup from './components/Signup';
import LoginActions from './actions/LoginActions';

var routes = (
  <Route handler={AuthenticatedApp}>
    <Route name="login" handler={Login}/>
    <Route name="home" path="/" handler={Home}/>
    <Route name="signup" handler={Signup}/>
  </Route>
);

var router = Router.create({routes});
RouterContainer.set(router);

let user = localStorage.getItem('user');
if (user != null) {
  LoginActions.loginUser(user);
}


router.run(function (Handler) {
  React.render(<Handler />, document.getElementById('main'));
});