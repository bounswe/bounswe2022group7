package com.group7.artshare.entity

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
    var bidder: RegisteredUser? = null

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "auctionBided")
    var auctionBided : Auction? = null
}