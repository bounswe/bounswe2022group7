package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonBackReference
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import lombok.Data
import java.util.*
import javax.persistence.*

@Data
@Entity
class AccountInfo(
    @Column
    var email: String,

    @Column(nullable = false)
    var username: String,

    @JsonIgnore
    @Column(nullable = false)
    private var password: String,
)
{
    @Id
    @GeneratedValue
    val id: Long = 0L

    @OneToOne(mappedBy = "accountInfo", cascade = [CascadeType.ALL])
    @JsonBackReference
    var registeredUser: RegisteredUser? = null

    @Column
    var name: String?=null

    @Column
    var surname: String?=null

    @Column
    var country: String?=null

    @Column
    var dateOfBirth: Date? = null

    @Column
    var profilePictureUrl: String?=null

    @JsonIgnore
    fun getPassword(): String {
        return password
    }

}