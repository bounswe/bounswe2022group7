import AddIcon from "@mui/icons-material/Add";
import Chip from "@mui/material/Chip";

export default function FilterChip({filterState, label, onClick}) {

    return (
        <Chip
            variant={"outlined"}
            color={filterState ? "primary" : "default"}
            onClick={onClick}
            onDelete={onClick}
            label={label}
            deleteIcon={filterState ? null : <AddIcon />}
        />
    );
}
