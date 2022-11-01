package com.group7.artshare.entity

import lombok.Data
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id


@Data
@Entity
class Artist {

    @Id
    @GeneratedValue
    val id: Long = 0L

    @Column
    var name: String = ""

    @Column
    var surname : String = ""
}