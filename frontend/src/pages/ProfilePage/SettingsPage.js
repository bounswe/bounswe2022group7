import React from 'react';

import { useAuth } from '../../auth/useAuth';

import EditUserInfo from "../../components/EditUserInfo";
import GenericCardLayout from "../../layouts/GenericCardLayout";
import Typography from '@mui/material/Typography';

export default function SettingsPage() {

    const [error, setError] = React.useState(null);
    const [userInfo, setUserInfo] = React.useState(
        {
            name: '',
            surname: '',
            country: '',
            dateOfBirth: '',
            image: '',
        }
    );

    const { token } = useAuth();


    //TODO: Fetch user info from backend
    React.useEffect(() => {

        const fetchArgs = {
            method: "GET",
        }
        if (token) fetchArgs.headers = { Authorization: "Bearer " + token }
        fetch("/api/profile/settings", fetchArgs)
            .then((response) => response.json())
            .then((data) => {
                if (data.error) {
                    setError(data.message);
                }
                else {
                    setUserInfo({
                        name: data.name,
                        surname: data.surname,
                        country: data.country,
                        dateOfBirth: data.dateOfBirth.split('T')[0],
                        image: data.profilePhotoId,
                    });
                }
            })
            .catch((error) => {
                setError(error.message);
            }
            );
    }, [token]
    )



    return (
        error ? <GenericCardLayout maxWidth={600}>
            <Typography variant="h4" component="h1" gutterBottom>
                {error}
            </Typography>
        </GenericCardLayout>
            :
            <GenericCardLayout maxWidth={600}>
                <EditUserInfo existingUser name={userInfo.name} surname={userInfo.surname} country={userInfo.country} dateOfBirth={userInfo.dateOfBirth} formName="Profile Details" formDescription="You can change your profile information." />
            </GenericCardLayout>
    );
}