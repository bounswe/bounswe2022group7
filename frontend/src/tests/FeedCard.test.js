
import { cleanup, render, screen } from '@testing-library/react';
import '@testing-library/jest-dom'
import FeedCard from '../pages/HomePage/FeedCard';
import { BrowserRouter } from 'react-router-dom';

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

    render(<BrowserRouter><FeedCard /></BrowserRouter>);

    expect(screen.getByRole('progressbar')).toHaveClass('MuiCircularProgress-root');
    expect(screen.getByText('undefined')).toBeInTheDocument();
    expect(screen.getByText('Untitled')).toBeInTheDocument();
    expect(screen.getByText('Lorem Impsum')).toBeInTheDocument();
    expect(screen.findByTestId('imageDisplay'));

});

test('Default render, logged in', async () => {
    mockToken = "testToken";

    render(<BrowserRouter><FeedCard /></BrowserRouter>);

    expect(screen.getByText('undefined')).toBeInTheDocument();
    expect(screen.getByText('Untitled')).toBeInTheDocument();
    expect(screen.getByText('Lorem Impsum')).toBeInTheDocument();
    expect(screen.findByTestId('imageDisplay'));
    expect(screen.getByTestId('followButton')).toHaveTextContent('Follow');
    expect(screen.getByTestId('bookmarkButton')).toHaveClass('MuiIconButton-root');
});

test('Default render, logged in, followed', async () => {
    mockToken = "testToken";

    let creator = {
        username: "undefined",
        followed: true,
        id: 0,
        imageId: 0
    }

    render(<BrowserRouter><FeedCard creator={creator} /></BrowserRouter>);

    expect(screen.getByText('undefined')).toBeInTheDocument();
    expect(screen.getByText('Untitled')).toBeInTheDocument();
    expect(screen.getByText('Lorem Impsum')).toBeInTheDocument();
    expect(screen.findByTestId('imageDisplay'));

    expect(screen.queryByTestId('followButton')).not.toBeInTheDocument();
    expect(screen.getByTestId('bookmarkButton')).toHaveClass('MuiIconButton-root');
});

test('Creator Details Different', async () => {
    // mockToken = "testToken";
    mockToken = null;

    let creator = {
        username: "tester",
        followed: false,
        id: 1,
        imageId: 1
    }

    render(<BrowserRouter><FeedCard creator={creator} /></BrowserRouter>);

    expect(screen.getByText('tester')).toBeInTheDocument();
    expect(screen.getByText('Untitled')).toBeInTheDocument();
    expect(screen.getByText('Lorem Impsum')).toBeInTheDocument();
    expect(screen.findByTestId('imageDisplay'));
    expect(screen.queryByTestId('followButton')).not.toBeInTheDocument();
    expect(screen.queryByTestId('bookmarkButton')).not.toBeInTheDocument();
});

test('Custom artwork, not signed in', async () => {
    mockToken = null;

    let customDate = "2021-05-01T00:00:00.000Z";

    let parsedDate = new Date(customDate);

    let content = {
        id: 1,
        title: "testTitle",
        description: "testDescription",
        imageId: 1,
        creationDate: customDate,
        type: "artitem"
    }

    render(<BrowserRouter><FeedCard content={content} /></BrowserRouter>);

    expect(screen.getByText('undefined')).toBeInTheDocument();
    expect(screen.getByText('testTitle')).toBeInTheDocument();
    expect(screen.getByText('testDescription')).toBeInTheDocument();
    expect(screen.getByText(`artwork`)).toBeInTheDocument();
    expect(screen.findByTestId('imageDisplay'));
    expect(screen.queryByTestId('followButton')).not.toBeInTheDocument();
    expect(screen.queryByTestId('bookmarkButton')).not.toBeInTheDocument();
});

test('Custom event, not signed in', async () => {
    mockToken = null;

    let customDate = "2021-05-01T00:00:00.000Z";

    let content = {
        bookmarked: false,
        id: 1,
        title: "testTitle",
        description: "testDescription",
        imageId: 1,
        creationDate: customDate,
        type: "event"
    }

    render(<BrowserRouter><FeedCard content={content} /></BrowserRouter>);

    expect(screen.getByText('undefined')).toBeInTheDocument();
    expect(screen.getByText('testTitle')).toBeInTheDocument();
    expect(screen.getByText('testDescription')).toBeInTheDocument();
    expect(screen.getByText(`event`)).toBeInTheDocument();
    expect(screen.findByTestId('imageDisplay'));
    expect(screen.queryByTestId('followButton')).not.toBeInTheDocument();
    expect(screen.queryByTestId('bookmarkButton')).not.toBeInTheDocument();
});

test('Custom discussion, not signed in', async () => {
    mockToken = null;

    let customDate = "2021-05-01T00:00:00.000Z";

    let content = {
        bookmarked: false,
        id: 1,
        title: "testTitle",
        description: "testDescription",
        imageId: 1,
        creationDate: customDate,
        type: "discussion"
    }

    render(<BrowserRouter><FeedCard content={content} /></BrowserRouter>);

    expect(screen.getByText('testTitle')).toBeInTheDocument();
    expect(screen.getByText('testDescription')).toBeInTheDocument();
    expect(screen.getByText(`discussion`)).toBeInTheDocument();

    expect(screen.queryByTestId('followButton')).not.toBeInTheDocument();
    expect(screen.queryByTestId('bookmarkButton')).not.toBeInTheDocument();


});

test("Default values, bookmarked & signed in", async () => {
    mockToken = "testToken";

    let content = {
        bookmarked: true,
        id: 0,
        title: "Undefined",
        description: "Lorem Impsum",
        imageId: 0,
        creationDate: "2021-05-01T00:00:00.000Z",
        type: "artitem"
    }
    render(<BrowserRouter><FeedCard content={content} /></BrowserRouter>);

    expect(screen.getByText('Undefined')).toBeInTheDocument();
    expect(screen.getByText('Lorem Impsum')).toBeInTheDocument();
    expect(screen.getByText(`artwork`)).toBeInTheDocument();
    expect(screen.queryByTestId('bookmarkButton')).toBeInTheDocument();
    expect(screen.queryByTestId('notBookmarked')).not.toBeInTheDocument();
    expect(screen.queryByTestId('bookmarked')).toBeInTheDocument();


});