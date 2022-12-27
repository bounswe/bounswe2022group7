import PropTypes from 'prop-types';

import * as React from 'react';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogTitle from '@mui/material/DialogTitle';
import LoadingButton from '../components/LoadingButton';

import { useAuth } from '../auth/useAuth';

export default function CopyrightReporter({ id, onResponse }) {

    const [open, setOpen] = React.useState(true);
    const [reportDescription, setReportDescription] = React.useState('');

    const { token } = useAuth();

    const sendReport = () => {
        setOpen(false);

        fetch('/api/report', {
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + token,
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ artItemId: id, description: reportDescription }),
        }
        ).then((response) => {
            console.log(response);
            if (response.ok) {
                onResponse("success", "Successfully reported content with id " + id);
            } else {
                onResponse("error", "Failed to report content with id " + id);
            }
        }).catch((error) => {
            onResponse("error", error);
        })
    }

    const handleReportDescriptionChange = (event) => {
        setReportDescription(event.target.value);
    }

    const handleCancel = () => {
        setOpen(false);
    }


    return (
        <div>
            <Dialog open={open} onClose={handleCancel}>
                <DialogTitle>Report Content</DialogTitle>
                <DialogContent>
                    <DialogContentText>
                        Please provide a description of why you are reporting this content.
                    </DialogContentText>
                    <TextField
                        autoFocus
                        margin="dense"
                        id="description"
                        label="Report Description"
                        type="text"
                        value={reportDescription}
                        fullWidth
                        multiline
                        maxRows={4}
                        variant="outlined"
                        onChange={(event) => handleReportDescriptionChange(event)}
                    />
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleCancel}>Cancel</Button>
                    <LoadingButton loadingText="Sending" onClick={sendReport} />
                </DialogActions>
            </Dialog>
        </div>
    );

}

CopyrightReporter.defaultProps = {
    id: 0,
}

CopyrightReporter.propTypes = {
    id: PropTypes.number,
}