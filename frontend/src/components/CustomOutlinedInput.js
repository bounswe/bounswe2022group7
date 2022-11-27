import OutlinedInput from '@mui/material/OutlinedInput';
import InputLabel from '@mui/material/InputLabel';
import InputHelperText from '@mui/material/FormHelperText';
import PropTypes from 'prop-types';

export default function CustomOutlinedInput(props) {

    const handleChange = (event) => {
        props.onChange(event.target.value);
    };

    return (
        <>
            <InputLabel htmlFor="uncontrolled-native" id="time-label">
                {props.label}
            </InputLabel>
            <OutlinedInput
                id="uncontrolled-native"
                fullWidth={props.fullWidth}
                name={props.name} 
                type={props.type || "text"}
                value={props.value} onChange={(event) => handleChange(event)} />
            <InputHelperText error={props.error} helperText={props.helperText} />
        </>
    )
}

CustomOutlinedInput.propTypes = {
    label: PropTypes.string.isRequired,
    value: PropTypes.string,
    onChange: PropTypes.func.isRequired,
    type: PropTypes.string,
    name: PropTypes.string,
    error: PropTypes.bool,
    helperText: PropTypes.string,
    fullWidth: PropTypes.bool,
}
