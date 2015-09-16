import React from 'react/addons';
import ReactMixin from 'react-mixin';
import Auth from '../services/AuthService';

export default class Login extends React.Component {

  constructor() {
    super()
    this.state = {
      user: '',
      password: ''
    };
  }

  login(e) {
    e.preventDefault();
    Auth.login(this.state.user, this.state.password)
      .catch(function(err) {
        alert("There's an error logging in");
        console.log("Error logging in", err);
    });
  }

  render() {
    return (
        <form className="form-signin">
          <h2 className="form-signin-heading text-center">Nivell</h2>
          <hr/>
          <div class="form-group">
            <label htmlFor="username" className="sr-only">Identifiant</label>
            <input type="text"  valueLink={this.linkState('user')} className="form-control" placeholder="Identifiant" autoFocus="true"/>
          </div>
          <div class="form-group">
            <label htmlFor="password" className="sr-only">Mot de passe</label>
            <input type="password" valueLink={this.linkState('password')} className="form-control" placeholder="Mot de passe" />
          </div>
          <button className="btn btn-warning btn-block" type="submit" onClick={this.login.bind(this)}>Connectez-vous</button>
        </form>
    );
  }
}

ReactMixin(Login.prototype, React.addons.LinkedStateMixin);