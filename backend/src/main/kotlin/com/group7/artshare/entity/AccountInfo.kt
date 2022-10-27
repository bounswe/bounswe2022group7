package com.group7.artshare.entity

import lombok.Data
import javax.persistence.*

@Data
@Entity
class AccountInfo {
    @Id
    @GeneratedValue
    val id: Long = 0L

    @OneToOne
    @JoinColumn(name = "registeredUser", referencedColumnName = "userId")
    var registeredUser: RegisteredUser? = null

    @Column
    var username: String = ""

    @Column
    var name: String = ""

    @Column
    var surname: String = ""

    @Column
    var age: Int? = null

    @Column
    var email: String = ""

    @Column
    var profilePictureUrl: String = ""

}