import AppDispatcher from '../dispatchers/AppDispatcher.js';
import {DISPLAY_DASHBOARD} from '../constants/TankConstants.js';
import RouterContainer from '../services/RouterContainer.js';

export default {

    dashboard: (tanks) => {

        //var savedUser = localStorage.getItem('user');

        AppDispatcher.dispatch({
            actionType: DISPLAY_DASHBOARD,
            tanks: tanks,
            //user: savedUser
        });
    }
}