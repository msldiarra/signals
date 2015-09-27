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
                <a className="black" href="#">
                    <div>
                        <div>
                            <h5><i className="fa fa-filter"></i> Cuve {this.props.tank.liquidType} {this.props.tank.name} dans la station de {this.props.tank.station} </h5>
                        </div>
                        <div className="progress">
                            <div className={progressBarClass} role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style={{width:this.props.tank.fillingRate + '%'}}>
                                <span>{this.props.tank.fillingRate}%</span>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        );
    }
}