import { cleanup, render, screen } from '@testing-library/react';
import '@testing-library/jest-dom'
import CommentSection from "../common/CommentSection";
import { BrowserRouter } from 'react-router-dom';

afterEach(() => {
  cleanup()
})

let mockToken = null;
jest.mock("../auth/useAuth", () => ({
  useAuth: () => {
    return { token: mockToken };
  }
}))

test("No token, no create comment button", async () => {
  mockToken = null;

  render (<BrowserRouter><CommentSection
    commentList= {[
      {
        "id": 0,
        "text": "some comment",
        "creationDate": "2022-12-05T16:17:21.094Z",
        "lastEditDate": "2022-12-05T16:17:21.094Z",
        "author": "David"
      }
    ]}
    contentId = {0}    
  /></BrowserRouter>)

  expect(
    screen.queryByText('Add Comment')
  ).not.toBeInTheDocument();
})

test("If there is a token, then there is a create comment button", async () => {
  
  mockToken = "testToken";

  render (<BrowserRouter><CommentSection
    commentList= {[
      {
        "id": 0,
        "text": "some comment",
        "creationDate": "2022-12-05T16:17:21.094Z",
        "lastEditDate": "2022-12-05T16:17:21.094Z",
        "author": "David"
      }
    ]}
    contentId = {0}    
  /></BrowserRouter>)

  const button = screen.getByRole('button');
  expect(button).not.toEqual(null);
})

test("Comment count is displayed correctly.", async () => {
  mockToken = null;

  render (<BrowserRouter><CommentSection
    commentList= {[
      {
        "id": 0,
        "text": "some comment",
        "creationDate": "2022-12-05T16:17:21.094Z",
        "lastEditDate": "2022-12-05T16:17:21.094Z",
        "author": "David"
      },
      {
        "id": 1,
        "text": "some comment 2",
        "creationDate": "2022-12-05T16:17:21.094Z",
        "lastEditDate": "2022-12-05T16:17:21.094Z",
        "author": "John"
      },
    ]}
    contentId = {0}    
  /></BrowserRouter>)

  const commentCountText = screen.getByText('Comment Section (2)');
  expect(commentCountText).not.toEqual(null);
})