import request from 'reqwest';
import when from 'when';
import rest from 'rest';
import {TANK_URL} from '../constants/TankConstants';
import TanksAction from '../actions/TanksActions';

class TankService {

    tanksInAlert(company) {

        return this.handleRequest(when(request({
            url: TANK_URL + company +"/alerted",
            method: 'GET',
            crossOrigin: true,
            type: 'json',

        })));


    }

    handleRequest(tanksPromise) {
        return tanksPromise
            .then((tanks) => {
                TanksAction.dashboard(tanks);
                console.log(tanks);
                return true;
            });
    }

    fetchTanks(company) {
        return rest(TANK_URL + company +"/alerted");
    }
}

export default new TankService()