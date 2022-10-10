import React from 'react'
import ReactDOM from 'react-dom/client'
import { act } from 'react-dom/test-utils'
import { Welcome } from '../src/Welcome'

describe('Welcome', () => {
    it('renders a greeting', () => {
        const name = 'guney'
        const component = <Welcome name={name} id="welcome" />
        const container = document.createElement('div')
        document.body.appendChild(container)

        act(() =>
            ReactDOM.createRoot(container).render(component)
        )

        expect(document.querySelector('#welcome').textContent)
            .toContain('Hello, guney')
    })
})
