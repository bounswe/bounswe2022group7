package com.group7.artshare.entity

import lombok.Data
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id

@Data
@Entity
class Image(
    @Column(columnDefinition = "MEDIUMTEXT")
    var base64String: String? = null
) {
    @Id
    @GeneratedValue
    val id: Long = 0L
}