package com.group7.artshare.entity

import lombok.Data
import javax.persistence.*


@Data
@Entity
class RegisteredUser
{
    @Id
    @GeneratedValue
    val userId: Long = 0L

    @OneToOne(cascade = [CascadeType.ALL])
    @JoinColumn(name = "accountInfo", referencedColumnName = "id")
    var accountInfo: AccountInfo? = null

    @Column
    var isVerified: Boolean = false

    @Column
    var level: Int = 0

    @Column
    var xp: Double = 0.0

    @Column
    var password: String = ""

    @ManyToMany(mappedBy = "followers", cascade = [CascadeType.ALL])
    var following: Set<RegisteredUser> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    var followers: Set<RegisteredUser> = HashSet()

    @ManyToMany(mappedBy = "blockedBy",cascade = [CascadeType.ALL])
    var blockedUsers: Set<RegisteredUser> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    var blockedBy: Set<RegisteredUser> = HashSet()

    @Column
    var isBanned: Boolean = false

    @ManyToMany(cascade = [CascadeType.ALL])
    var allPhysicalExhibitions: Set<PhysicalExhibition> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    var allOnlineGalleries: Set<OnlineGallery> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    var bookmarkedArtItems: Set<ArtItem> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    var bookmarkedPhysicalExhibitions: Set<PhysicalExhibition> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    var bookmarkedOnlineGalleries: Set<OnlineGallery> = HashSet()

    //TODO discussion post
    //TODO past reply past posts
    //TODO read notifications
    //TODO unread notifications
    //TODO current bids

}