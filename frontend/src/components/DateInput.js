import OutlinedInput from '@mui/material/OutlinedInput';
import InputLabel from '@mui/material/InputLabel';
import InputHelperText from '@mui/material/FormHelperText';
import PropTypes from 'prop-types';

export default function DateInput(props) {

    return (
        <>
            <InputLabel htmlFor="uncontrolled-native" id="date-label">
                {props.label}
            </InputLabel>
            <OutlinedInput fullWidth={props.fullWidth} name={props.name} id={props.id} type="date" value={props.value} onChange={props.onChange} />
            <InputHelperText error={props.error} helperText={props.helperText} />
        </>
    )
}

DateInput.propTypes = {
    label: PropTypes.string.isRequired,
    value: PropTypes.string.isRequired,
    onChange: PropTypes.func.isRequired,
    name: PropTypes.string,
    error: PropTypes.bool,
    helperText: PropTypes.string,
    fullWidth: PropTypes.bool,
}
