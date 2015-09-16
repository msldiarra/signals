import React from 'react/addons';

export default class AlertBar extends React.Component {

    constructor() {
        super();
    }

    render() {
        let inlineWidth = "width:40%";

        let progressBarClass = "progress-bar progress-bar-danger";

        return (
            <div>
                <a href="#">Cuve {this.props.tank.liquidType} {this.props.tank.name} dans la station de {this.props.tank.station}</a>
                <div className="progress">
                    <div className={progressBarClass} role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style={{width:"40%"}}>
                        <span>{this.props.tank.level}%</span>
                    </div>
                </div>
            </div>
        );
    }
}