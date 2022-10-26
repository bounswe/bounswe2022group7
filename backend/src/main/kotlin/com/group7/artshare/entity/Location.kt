package com.group7.artshare.entity

import lombok.Data
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Table

@Data
@Entity
@Table(name = "location")
class Location {
    @Id
    @GeneratedValue
    val id: Long = 0L
}