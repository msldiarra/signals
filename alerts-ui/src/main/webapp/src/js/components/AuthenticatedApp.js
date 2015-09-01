'use strict';

import React from 'react';
import LoginStore from '../stores/LoginStore'
import { Route, RouteHandler, Link } from 'react-router';
import AuthService from '../services/AuthService'

export default class AuthenticatedApp extends React.Component {

  constructor() {
    super()
    this.state = this._getLoginState();
  }

  _getLoginState() {
    return {
      userLoggedIn: LoginStore.isLoggedIn()
    };
  }

  componentDidMount() {
    this.changeListener = this._onChange.bind(this);
    LoginStore.addChangeListener(this.changeListener);
  }

  _onChange() {
    this.setState(this._getLoginState());
  }

  componentWillUnmount() {
    LoginStore.removeChangeListener(this.changeListener);
  }

  render() {
    return (
    <div>
          {this.header}
          <div className="content">
              <div className="container">
                <RouteHandler/>
              </div>
          </div>
    </div>
    );
  }

  logout(e) {
    e.preventDefault();
    AuthService.logout();
  }


  get header() {

    if (!this.state.userLoggedIn) {
      return;
    }
    else {

      return (
           <nav className="navbar navbar-custom navbar-fixed-top" role="navigation">
              <div className="container-fluid">
                  <div className="navbar-header">
                      <button type="button" className="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                          <span className="sr-only">Toggle navigation</span>
                          <span className="icon-bar"></span>
                          <span className="icon-bar"></span>
                          <span className="icon-bar"></span>
                      </button>
                      <a className="navbar-brand" href="#">NIVELL</a>
                  </div>
                  <div className="collapse navbar-collapse navbar-ex1-collapse">
                        {this.headerItems}
                  </div>
              </div>
          </nav>)
    }

  }

  get headerItems() {
    if (!this.state.userLoggedIn) {
      return;
    } else {
      return (
          <ul className="nav navbar-nav navbar-right">
              <li className="active"><Link to="home">Dashboard</Link></li>
              <li><a href="" onClick={this.logout}>Déconnexion</a></li>
          </ul>)
    }
  }
}
