package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonIdentityInfo
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.ObjectIdGenerators
import lombok.Data
import java.util.*
import javax.persistence.*

@Data
@Entity
class Bid {

    @Id
    @GeneratedValue
    var id: Long = 0L

    @Column
    var bidAmount: Double = 0.0

    @ManyToOne(fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    @JoinColumn(name = "bidder")
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var bidder: RegisteredUser? = null

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "artItemBided")
    @JsonIgnore
    var artItemBided : ArtItem? = null
}