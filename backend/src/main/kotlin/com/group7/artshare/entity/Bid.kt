package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonIdentityInfo
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
    @Temporal(TemporalType.TIMESTAMP)
    var expirationDate: Date? = null

    @ManyToOne(fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    @JoinColumn(name = "bidder")
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var bidder: RegisteredUser? = null

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "auctionBided")
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var auctionBided : Auction? = null
}