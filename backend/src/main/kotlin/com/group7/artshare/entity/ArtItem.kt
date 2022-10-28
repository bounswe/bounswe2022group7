package com.group7.artshare.entity

import lombok.Data;
import java.util.*
import javax.persistence.*;

@Data
@Entity
class ArtItem{

    @Id
    @GeneratedValue
    var id: Long = 0L

    @OneToOne
    @JoinColumn(name = "artItemInfo", referencedColumnName = "id")
    var artItemInfo: ArtItemInfo? = null

    /*
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    var creator: Artist? = null

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var creationDate: Date = Calendar.getInstance().time

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "owner")
    var owner: RegisteredUser? = null

    @Column
    var onAuction: Boolean = false

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "auction")
    var auction: Auction? = null

    @Column
    var lastPrice: Double = 0.0;

    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    var commentList: List<Comment> = ArrayList()

    @ManyToMany(mappedBy = "bookmarkedArtItems",cascade = [CascadeType.ALL])
    var bookmarkedBy: Set<RegisteredUser> = HashSet()

     */
}