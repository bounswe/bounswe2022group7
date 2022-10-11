import ReactDOM from 'react-dom/client'
import React from 'react'

export class Welcome extends React.Component {
    render() {
        return (
            <p id={this.props.id}>Hello, {this.props.name}</p>
        )
    }
}

const root = document.querySelector('#root')
ReactDOM.createRoot(root).render(<Welcome name="guney" />)
