import Button from '@mui/material/Button';
import CircularProgress from '@mui/material/CircularProgress';

import PropTypes from 'prop-types';

export default function LoadingButton(props) {

    return (
        <Button
            type={props.type}
            variant={props.variant}
            color={props.color}
            size={props.size}
            onClick={props.onClick}
            disabled={props.disabled || props.loading}
            startIcon={props.loading && (props.loadingIcon)}
            sx={props.sx}
        >
            {props.loading ? props.loadingText : props.label}
        </Button>

    );

}

LoadingButton.propTypes = {
    loadingText: PropTypes.string,
    loading: PropTypes.bool,
    type: PropTypes.string,
    variant: PropTypes.string,
    color: PropTypes.string,
    size: PropTypes.string,
    onClick: PropTypes.func,
    disabled: PropTypes.bool,
    loadingIcon: PropTypes.element,
    label: PropTypes.string,
    sx: PropTypes.object,
}

LoadingButton.defaultProps = {
    loadingText: 'Loading',
    loading: false,
    type: 'button',
    variant: 'contained',
    color: 'primary',
    size: 'medium',
    loadingIcon: <CircularProgress size={16} color="inherit" />,
    label: 'Submit',
    disabled: false,
}