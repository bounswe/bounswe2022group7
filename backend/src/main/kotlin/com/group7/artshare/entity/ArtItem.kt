package com.group7.artshare.entity

import lombok.Data;
import java.util.*
import javax.persistence.*;

@Data
@Entity
class ArtItem{

    @Id
    @GeneratedValue
    val itemId: Long = 0L

    @OneToOne
    @JoinColumn(name = "artItemInfo", referencedColumnName = "id")
    val artItemInfo: ArtItemInfo = null

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    val creator: Artist = null

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    val creationDate: Date = Calendar.getInstance().time

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "owner")
    val owner: RegisteredUser = null

    @Column
    val onAuction: Boolean = false

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "auction")
    val auction: Auction = null

    @Column
    val lastPrice: Double = 0.0;

    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    val commentList: List<Comment> = ArrayList()
}