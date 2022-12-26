import { cleanup, render, screen } from '@testing-library/react';
import { BrowserRouter } from 'react-router-dom';
import Profile from "../pages/ProfilePage/Profile";
import '@testing-library/jest-dom'

afterEach(() => {
    cleanup();
});

let mockToken = null;
jest.mock("../auth/useAuth", () => ({
    useAuth: () => {
        return { token: mockToken };
    }
}))


test('Default render, not logged in', async () => {

    render(<BrowserRouter><Profile /></BrowserRouter>);

    expect(screen.getByText('Following')).toBeInTheDocument();

});

test('Default render, logged in', async () => {

    mockToken = "testToken";
    
    render(<BrowserRouter><Profile /></BrowserRouter>);

    expect(screen.getByText('Following')).toBeInTheDocument();

});