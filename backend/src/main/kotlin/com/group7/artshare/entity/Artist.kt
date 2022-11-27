package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.*
import java.util.ArrayList
import javax.persistence.*

@Entity(name="Artist")
class Artist(accountInfo: AccountInfo, authorities: Set<Authority>) : RegisteredUser(accountInfo, authorities) {

    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var copyrightedArtItems: MutableSet<ArtItem> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "artist_hosted_events",
        joinColumns = [JoinColumn(name = "artist_id", referencedColumnName = "id")],
        inverseJoinColumns = [JoinColumn(name = "event_id", referencedColumnName = "id")]
    )
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var hostedEvents: MutableSet<Event> = mutableSetOf()

    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var artItems: MutableSet<ArtItem> = mutableSetOf()

    @Column
    var totalSales: Int = 0

    @Column
    var totalAmountRaised: Double = 0.0

    @Column
    var totalEvents: Int = 0

}