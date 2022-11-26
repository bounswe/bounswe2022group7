package com.group7.artshare

import lombok.Data
import lombok.RequiredArgsConstructor
import java.util.*

@Data
@RequiredArgsConstructor
class SettingDTO {
    var email: String? = null
    var username: String? = null
    var name: String? = null
    var surname: String? = null
    var country: String? = null
    var dateOfBirth : Date? = null
    var profilePictureId : Long? = null
}