
import { cleanup, render, screen } from '@testing-library/react';
import '@testing-library/jest-dom'
import CopyrightReporter from '../common/CopyrightReporter';

// import { BrowserRouter } from 'react-router-dom';

afterEach(() => {
    cleanup();
});

let mockToken = null;
jest.mock("../auth/useAuth", () => ({
    useAuth: () => {
        return { token: mockToken };
    }
}))


test('Default render, not signed in', async () => {

    mockToken = null;
    render(<CopyrightReporter />);

    expect(screen.getByText('Submit')).toHaveClass('MuiButton-root MuiButton-contained MuiButton-containedPrimary');
    expect(screen.getByText('Cancel')).toHaveClass('MuiButton-root MuiButton-text MuiButton-textPrimary');
    expect(screen.getByText('Please provide a description of why you are reporting this content.')).toBeInTheDocument();
    expect(screen.getByText('Report Content')).toBeInTheDocument();


});


test('Default render, not signed in', async () => {

    mockToken = "placeholdertoken";
    render(<CopyrightReporter />);

    expect(screen.getByText('Submit')).toHaveClass('MuiButton-root MuiButton-contained MuiButton-containedPrimary');
    expect(screen.getByText('Cancel')).toHaveClass('MuiButton-root MuiButton-text MuiButton-textPrimary');
    expect(screen.getByText('Please provide a description of why you are reporting this content.')).toBeInTheDocument();
    expect(screen.getByText('Report Content')).toBeInTheDocument();

});
