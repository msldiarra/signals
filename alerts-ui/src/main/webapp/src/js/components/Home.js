import React from 'react';
import AuthenticatedComponent from './AuthenticatedComponent'
import TanksInAlert from './TanksInAlert.js'

export default AuthenticatedComponent(class Home extends React.Component {


  render() {

    return <div>
              <h2>Dashboard</h2>
              <TanksInAlert user={this.props.user}/>
           </div>;
  }
});