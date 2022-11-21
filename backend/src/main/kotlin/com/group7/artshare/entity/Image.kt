package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonBackReference
import com.fasterxml.jackson.annotation.JsonManagedReference
import lombok.Data
import java.util.*
import javax.persistence.*

@Data
@Entity
class Image {

    @Id
    @GeneratedValue
    val id: Long = 0L

    @Column(columnDefinition = "MEDIUMTEXT")
    var base64String : String? = null
}