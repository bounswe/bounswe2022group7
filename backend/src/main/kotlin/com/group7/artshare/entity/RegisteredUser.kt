package com.group7.artshare.entity

import lombok.Data
import javax.persistence.*


@Data
@Entity
class RegisteredUser ()
{
    @Id
    @GeneratedValue
    val itemId: Long = 0L

    //TODO accountInfo

    @Column
    var isVerified: Boolean = false

    @Column
    var level: Int = 0

    @Column
    var xp: Double = 0.0

    @Column
    var password: String = ""

    @ManyToMany( cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "following",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "following_user_id")]
    )
    var following: MutableSet<RegisteredUser> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "followers",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "follower_user_id")]
    )
    var followers: MutableSet<RegisteredUser> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "blocked_users",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "blocked_user_id")]
    )
    var blockedUsers: MutableSet<RegisteredUser> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "blocked_by",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "blocked_by_user_id")]
    )
    var blockedBy: MutableSet<RegisteredUser> = mutableSetOf()

    @Column
    var isBanned: Boolean = false

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "all_physical_exhibitions",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "exhibition_id")]
    )
    var allPhysicalExhibitions: MutableSet<PhysicalExhibition> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "online_galleries",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "online_gallery_id")]
    )
    var allOnlineGalleries: MutableSet<OnlineGallery> = mutableSetOf()


    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "bookmarked_art_items",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "art_item_id")]
    )
    var bookmarkedArtItems: MutableSet<ArtItem> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "bookmarked_exhibitions",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "physical_exhibition_id")]
    )
    var bookmarkedPhysicalExhibitions: MutableSet<PhysicalExhibition> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "bookmarked_online_galleries",
        joinColumns = [JoinColumn(name = "following_user_id")],
        inverseJoinColumns = [JoinColumn(name = "online_gallery_id")]
    )
    var bookmarkedOnlineGalleries: MutableSet<OnlineGallery> = mutableSetOf()


    //TODO discussion post
    //TODO past reply past posts
    //TODO read notifications
    //TODO unread notifications
    //TODO current bids

}