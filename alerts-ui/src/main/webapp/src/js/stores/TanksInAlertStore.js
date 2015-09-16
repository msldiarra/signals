import {DISPLAY_DASHBOARD} from '../constants/TankConstants';
import BaseStore from './BaseStore';
import LoginStore from './LoginStore';
import TankService from '../services/TankService';
import jwt_decode from 'jwt-decode';

class TanksInAlertStore extends BaseStore {

    constructor() {
        super();
        this.subscribe(() => this._registerToActions.bind(this))
        this._tanks= null;
    }

    _registerToActions(action) {

        console.log(action);

        switch(action.actionType) {

            case DISPLAY_DASHBOARD:
                this._tanks = action.tanks;
                this.emitChange();
                break;

            default:
                break;
        };
    }

    get tanks() {
        return this._tanks;
    }
}

export default new TanksInAlertStore();