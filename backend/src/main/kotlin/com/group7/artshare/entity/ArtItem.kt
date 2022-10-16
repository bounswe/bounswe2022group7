package com.group7.artshare.entity

import lombok.Data;
import javax.persistance.*;

@Data
@Entity
class ArtItem{

    @Id
    @GeneratedValue
    private itemId;

    @OneToOne
    @JoinColumn(name = "artItemInfo", referencedColumnName = "id")
    EventInfo eventInfo;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    Artist creator;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date creationDate;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "owner")
    RegisteredUser owner;

    @Column
    Boolean onAuction;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "auction")
    Auction auction;

    @Column
    Double lastPrice;

    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    List<Comment> commentList;
}