import React from 'react';
import AuthenticatedComponent from './AuthenticatedComponent'

export default AuthenticatedComponent(class Home extends React.Component {
  render() {
    return (<h1>Votre tableau de bord</h1>);
  }
});