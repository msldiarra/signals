import React from 'react/addons';
import ReactMixin from 'react-mixin';
import LoginStore from '../stores/LoginStore';
import Tanks from '../services/TankService';
import TanksInAlertStore from '../stores/TanksInAlertStore';
import AlertBar from './AlertBar';


export default class TanksInAlert extends React.Component {

    constructor() {
        super();
        this.state = this._getTanksInAlert();
    }


    _getTanksInAlert() {

        if(TanksInAlertStore.tanks == null) {
            console.log("init... searching for tanks for company : " + LoginStore.user.company)
            Tanks.tanksInAlert(LoginStore.user.company);
        }

        let tanksInAlert = TanksInAlertStore.tanks == null ? [] : TanksInAlertStore.tanks;
        console.log("retieved tanks from store : ");
        console.log(tanksInAlert);


        return {tanks: tanksInAlert};
    }

    componentDidMount() {
        this.changeListener = this._onChange.bind(this);
        TanksInAlertStore.addChangeListener(this.changeListener);
        LoginStore.addChangeListener(this.changeListener);
    }

    _onChange() {
        this.setState(this._getTanksInAlert());
    }

    componentWillUnmount() {
        TanksInAlertStore.removeChangeListener(this.changeListener);
        LoginStore.removeChangeListener(this.changeListener);
    }

    render() {
        var bars = this.state.tanks.map(function(tank){
            return <AlertBar key={tank.id} tank={tank} />

        })

        return (
            <div className="padding-25">
                {bars}
            </div>
        );
    }
}