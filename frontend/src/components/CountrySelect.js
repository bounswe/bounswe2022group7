import * as React from 'react';
import TextField from '@mui/material/TextField';
import Autocomplete from '@mui/material/Autocomplete';
import countries from '../common/CountryList';

import PropTypes from 'prop-types';

export default function CountrySelect(props) {

    // export default function ControllableStates() {
    const [value, setValue] = React.useState(null);
    const [inputValue, setInputValue] = React.useState('');

    const handleInputChange = (event, newInputValue) => {
        setInputValue(newInputValue);
    };

    const handleChange = (event, newValue) => {
        setValue(newValue);
        newValue ? props.onChange(newValue.code) : props.onChange(null);
    };

    return (
        <div>
            <Autocomplete
                value={value}
                onChange={(event, newValue) => handleChange(event, newValue)}
                inputValue={inputValue}
                onInputChange={(event, newInputValue) => handleInputChange(event, newInputValue)}
                id="controllable-states-demo"
                options={countries}
                sx={{ width: props.width || 300 }}
                getOptionLabel={(option) => option.label}
                renderInput={(params) => <TextField {...params}
                    label={props.label || ""}
                    inputProps={{
                        ...params.inputProps,
                        autoComplete: 'new-password', // disable autocomplete and autofill 
                    }}
                />}
            />
        </div>
    );
}   

CountrySelect.propTypes = {
    label: PropTypes.string,
    onChange: PropTypes.func.isRequired,
};
