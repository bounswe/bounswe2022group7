import { cleanup, render, screen } from '@testing-library/react';
import '@testing-library/jest-dom'
import LoadingButton from '../components/LoadingButton';


afterEach(() => {
   cleanup();
});

test('Default options, render', async () => {
   render(<LoadingButton />);

   const button = screen.getByRole('button');
   expect(button).toHaveTextContent('Submit');
   expect(button).toHaveAttribute('type', 'button');
   expect(button).toHaveClass('MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium');
   expect(button).toBeEnabled()

});

test("Default options, should show loading", async () => {

   render(<LoadingButton loading={true} />);

   const button = screen.getByRole('button');
   expect(button).toHaveTextContent('Loading');
   expect(button).toHaveAttribute('type', 'button');
   expect(button).toHaveClass('MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium');
   expect(button).toBeDisabled();

})

test("Custom Label Text", async () => {

   const text = "Save"
   render(<LoadingButton label={text} />);

   const button = screen.getByRole('button');
   expect(button).toHaveTextContent(text);
   expect(button).toHaveAttribute('type', 'button');
   expect(button).toHaveClass('MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium');
   expect(button).toBeEnabled();
})


test("Custom Loading Text", async () => {

   const loadText = "Saving"
   render(<LoadingButton loading={true} loadingText={loadText} />);

   const button = screen.getByRole('button');
   expect(button).toHaveTextContent(loadText);
   expect(button).toHaveAttribute('type', 'button');
   expect(button).toHaveClass('MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium');
   expect(button).toBeDisabled();
})

test("Custom Button Type", async () => {

   const type = "submit"
   render(<LoadingButton type={type} />);

   const button = screen.getByRole('button');
   expect(button).toHaveTextContent('Submit');
   expect(button).toHaveAttribute('type', type);
   expect(button).toHaveClass('MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium');
   expect(button).toBeEnabled();
})

test("Custom Button Variant", async () => {

   const variant = "outlined"
   render(<LoadingButton variant={variant} />);

   const button = screen.getByRole('button');
   expect(button).toHaveTextContent('Submit');
   expect(button).toHaveAttribute('type', 'button');
   expect(button).toHaveClass(`MuiButtonBase-root MuiButton-root MuiButton-${variant} MuiButton-${variant}Primary MuiButton-sizeMedium`);
   expect(button).toBeEnabled();
})

test("Custom Button Color", async () => {
   render(<LoadingButton color={"success"} />);

   const button = screen.getByRole('button');
   expect(button).toHaveTextContent('Submit');
   expect(button).toHaveAttribute('type', 'button');
   expect(button).toHaveClass('MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedSuccess MuiButton-sizeMedium');
   expect(button).toBeEnabled();
})

test("Custom Button Size", async () => {
   render(<LoadingButton size={"small"} />);

   const button = screen.getByRole('button');
   expect(button).toHaveTextContent('Submit');
   expect(button).toHaveAttribute('type', 'button');
   expect(button).toHaveClass('MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeSmall');
   expect(button).toBeEnabled();
})

test("Button Disabled", async () => {
   render(<LoadingButton disabled={true} />);

   const button = screen.getByRole('button');
   expect(button).toHaveTextContent('Submit');
   expect(button).toHaveAttribute('type', 'button');
   expect(button).toBeDisabled();
})

test("Custom Loading Icon", async () => {
   render(<LoadingButton loading={true} loadingIcon={<div>testIcon</div>} />);

   const button = screen.getByRole('button');
   expect(button).toHaveTextContent('testIconLoading');
   expect(button).toHaveAttribute('type', 'button');
   expect(button).toBeDisabled();
})

   