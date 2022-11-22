package com.group7.artshare.entity

import lombok.Data
import javax.persistence.*

@Data
@Entity
@Table(name = "location")
class Location {
    @Id
    @GeneratedValue
    val id: Long = 0L

    @Column
    var latitude: Double = 0.0

    @Column
    var longitude: Double = 0.0

    @Column
    var address: String = ""
}