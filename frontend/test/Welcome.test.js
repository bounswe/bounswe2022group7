import React from 'react'
import ReactDOM from 'react-dom/client'
import { act } from 'react-dom/test-utils'
import { Welcome } from '../src/Welcome'

describe('Welcome', () => {
    let container

    beforeEach(() => {
        container = document.createElement('div')
        document.body.replaceChildren(container)

    })

    const render = component => {
        act(() =>
            ReactDOM.createRoot(container).render(component)
        )
        
    }

    it('renders a greeting', () => {
        const name = 'guney'

        render(<Welcome name={name} id="welcome" />)

        expect(document.querySelector('#welcome').textContent)
            .toContain('Hello, guney')
    })
})
