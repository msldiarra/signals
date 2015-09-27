import React from 'react';
import AuthenticatedComponent from './AuthenticatedComponent'
import TanksInAlert from './TanksInAlert.js'

export default AuthenticatedComponent(class Home extends React.Component {


  render() {

    return <div>
              <h2><i className="fa fa-bar-chart"></i> Cuves en alerte</h2>
              <TanksInAlert user={this.props.user}/>
           </div>;
  }
});