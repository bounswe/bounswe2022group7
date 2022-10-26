package com.group7.artshare.entity

import lombok.Data
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id


@Data
@Entity
class RegisteredUser {

    @Id
    @GeneratedValue
    val itemId: Long = 0L

}