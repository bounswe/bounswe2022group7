import React from 'react'

export class Welcome extends React.Component {
    render() {
        return (
            <p id={this.props.id}>Hello, {this.props.name}</p>
        )
    }
}
