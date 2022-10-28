package com.group7.artshare.entity

import lombok.Data
import javax.persistence.*

@Data
@Entity
class AccountInfo(
    @Column(nullable = false)
    var username: String,

    @Column(nullable = false)
    private var password: String,
)
{
    @Id
    @GeneratedValue
    val id: Long = 0L

    @OneToOne(mappedBy = "accountInfo", cascade = [CascadeType.ALL])
    var registeredUser: RegisteredUser? = null

    @Column
    var name: String?=null

    @Column
    var surname: String?=null

    @Column
    var age: Int? = null

    @Column
    var email: String?=null

    @Column
    var profilePictureUrl: String?=null

    fun getPassword(): String {
        return password
    }

}