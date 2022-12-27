import React from 'react'

import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import Container from '@mui/material/Container';
import InputBase from '@mui/material/InputBase';
import MenuIcon from '@mui/icons-material/Menu';
import Paper from '@mui/material/Paper';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import Stack from '@mui/material/Stack';

import AddIcon from '@mui/icons-material/Add';
import BrushIcon from '@mui/icons-material/Brush';
import EventIcon from '@mui/icons-material/Event';
import ForumIcon from '@mui/icons-material/Forum';
import SearchIcon from '@mui/icons-material/Search';
import LoginIcon from '@mui/icons-material/Login';
import EditIcon from '@mui/icons-material/Edit';
import AccountCircleIcon from '@mui/icons-material/AccountCircle';
import ExitToAppIcon from '@mui/icons-material/ExitToApp';
import HowToRegIcon from '@mui/icons-material/HowToReg';
import CollectionsIcon from '@mui/icons-material/Collections';

import { useNavigate } from 'react-router-dom';
import { useAuth } from "./auth/useAuth";

import CustomizableDropdownMenu from './components/CustomizableDropdownMenu';
import UserAvatar from './components/UserAvatar';
import LoadingButton from './components/LoadingButton';
import { replace } from 'formik';

const ResponsiveAppBar = () => {

    const navigate = useNavigate()
    const { token, clearToken, userData } = useAuth()

    const [searchValue, setSearchValue] = React.useState("")

    const handleChange = (event) => {
        setSearchValue(event.target.value);
    };

    const keyPress = (event) => {
        if (event.keyCode == 13) {
            handleSearch();
        }
    }

    const handleSearch = () => {
        navigate(`/search?keywords=${encodeURIComponent(searchValue)}`);
        setSearchValue("");
        window.location.reload();
    }

    let authContent = [
        {
            label: "Sign In",
            icon: <LoginIcon />,
            action: () => {
                navigate('/auth/signin');
            }
        },
        {
            label: "Sign Up",
            icon: <HowToRegIcon />,
            action: () => {
                navigate('/auth/signup');
            }
        },
    ]

    let newContent = [
        {
            label: "New Art Item",
            icon: <BrushIcon />,
            action: () => {
                navigate('/artitem/new');
            }
        },
        {
            label: "New Physical Event",
            icon: <EventIcon />,
            action: () => {
                navigate('/event/newPhysical');
            }
        },
        {
            label: "New Online Event",
            icon: <CollectionsIcon />,
            action: () => {
                navigate('/event/newOnline');
            }
        },
        {
            label: "New Discussion",
            icon: <ForumIcon />,
            action: () => {
                navigate('/discussionPost/new');
            }
        },
    ]

    let menuContent = [
        {
            label: "Profile",
            icon: <AccountCircleIcon />,
            action: () => {
                navigate('/profile/' + userData.accountInfo.username);
            }
        },
        {
            label: "Edit Profile",
            icon: <EditIcon />,
            action: () => {
                navigate('/profile/settings');
            }
        },
        {
            label: "Logout",
            icon: <ExitToAppIcon />,
            action: () => {
                clearToken();
                navigate('/');
            }
        }
    ]

    return (
        <AppBar position="static" color='secondary'>
            <Container maxWidth="xl">
                <Toolbar disableGutters>
                    <Typography
                        variant="h6"
                        noWrap
                        component="a"
                        href="/"
                        sx={{
                            mr: 2,
                            display: { xs: 'none', md: 'flex' },
                            fontFamily: 'monospace',
                            fontWeight: 700,
                            letterSpacing: '.2rem',
                            color: 'inherit',
                            textDecoration: 'none',
                        }}
                    >
                        ideart.
                    </Typography>

                    <Box sx={{ flexGrow: 1, display: { xs: 'flex', md: 'none' } }}>
                        <CustomizableDropdownMenu tooltip={"Menu"} icon={<MenuIcon color='inherit' />} menuContent={authContent} sx={{ color: 'white' }} />
                    </Box>
                    <Typography
                        variant="h5"
                        noWrap
                        component="a"
                        href="/"
                        sx={{
                            mr: 2,
                            display: { xs: 'flex', md: 'none' },
                            flexGrow: 1,
                            fontFamily: 'monospace',
                            fontWeight: 700,
                            letterSpacing: '.3rem',
                            color: 'inherit',
                            textDecoration: 'none',
                        }}
                    >
                        ideart.
                    </Typography>
                    <Box sx={{ flexGrow: 1, display: { xs: 'none', md: 'flex' }, justifyContent: 'center' }}>
                        <Paper sx={{ width: '100%', maxWidth: 500 }} >
                            <Box sx={{ width: '100%', display: 'flex', alignItems: 'flex-end' }}>
                                <SearchIcon sx={{ color: 'action.active', mr: 1, my: 0.5 }} />
                                <InputBase onKeyDown={keyPress} value={searchValue} onChange={handleChange} size="small" sx={{ width: '100%', maxWidth: 500 }} />
                            </Box>
                        </Paper>
                        {searchValue && <LoadingButton sx={{ ml: 1 }} variant="contained" size="small" onClick={handleSearch} label="Search" />}

                    </Box>

                    {(token && userData) ?
                        <>
                            <Box sx={{ flexGrow: 0 }}>
                                <CustomizableDropdownMenu
                                    menuContent={newContent}
                                    tooltip="Create"
                                    menuIcon={
                                        <Stack direction="row" spacing={1} alignItems="center"
                                            sx={{ borderRadius: '5%', p: 0.5, border: 1, borderColor: 'white', fontSize: 16, fontWeight: 600, color: 'white', }}>
                                            CREATE <AddIcon sx={{ fontSize: 18 }} />
                                        </Stack>
                                    }
                                />
                            </Box>
                            <Box sx={{ flexGrow: 0 }}>
                                <CustomizableDropdownMenu menuContent={menuContent} tooltip="Profil" menuIcon={<UserAvatar id={userData.accountInfo.profilePictureId} sx={{ innterWidth: 40, innerHeight: 40, border: 1.5, borderColor: 'white' }} />} />
                            </Box>
                        </>
                        :
                        <Box sx={{ flexGrow: 0, display: { xs: 'none', md: 'flex' } }}>
                            {authContent.map((page) => (
                                <Button
                                    key={page.label}
                                    onClick={page.action}
                                    size="large"
                                    sx={{ my: 2, color: 'white', display: 'block', fontWeight: 700, letterSpacing: '0.05rem' }}>
                                    {page.label}
                                </Button>
                            ))}

                        </Box>


                    }
                </Toolbar>
            </Container>
        </AppBar>
    );
};
export default ResponsiveAppBar;