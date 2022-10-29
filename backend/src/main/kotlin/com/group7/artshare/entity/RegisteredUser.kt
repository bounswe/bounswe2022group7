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

    @ManyToMany( cascade = [CascadeType.ALL])
    @JoinTable(
        name = "following",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "following_user_id")]
    )
    var following: Set<RegisteredUser> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    @JoinTable(
        name = "followers",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "follower_user_id")]
    )
    var followers: Set<RegisteredUser> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    @JoinTable(
        name = "blocked_users",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "blocked_user_id")]
    )
    var blockedUsers: Set<RegisteredUser> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    @JoinTable(
        name = "blocked_by",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "blocked_by_user_id")]
    )
    var blockedBy: Set<RegisteredUser> = HashSet()

    @Column
    var isBanned: Boolean = false

    @ManyToMany(cascade = [CascadeType.ALL])
    @JoinTable(
        name = "all_physical_exhibitions",
        joinColumns = [JoinColumn(name = "exhibition_id")],
        inverseJoinColumns = [JoinColumn(name = "user_id")]
    )
    var allPhysicalExhibitions: Set<PhysicalExhibition> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    @JoinTable(
        name = "online_galleries",
        joinColumns = [JoinColumn(name = "online_gallery_id")],
        inverseJoinColumns = [JoinColumn(name = "user_id")]
    )
    var allOnlineGalleries: Set<OnlineGallery> = HashSet()


    @ManyToMany(cascade = [CascadeType.ALL])
    @JoinTable(
        name = "bookmarked_art_items",
        joinColumns = [JoinColumn(name = "art_item_id")],
        inverseJoinColumns = [JoinColumn(name = "user_id")]
    )
    var bookmarkedArtItems: Set<ArtItem> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    @JoinTable(
        name = "bookmarked_exhibitions",
        joinColumns = [JoinColumn(name = "physical_exhibition_id")],
        inverseJoinColumns = [JoinColumn(name = "user_id")]
    )
    var bookmarkedPhysicalExhibitions: Set<PhysicalExhibition> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    @JoinTable(
        name = "bookmarked_online_galleries",
        joinColumns = [JoinColumn(name = "online_gallery_id")],
        inverseJoinColumns = [JoinColumn(name = "following_user_id")]
    )
    var bookmarkedOnlineGalleries: Set<OnlineGallery> = HashSet()


    //TODO discussion post
    //TODO past reply past posts
    //TODO read notifications
    //TODO unread notifications
    //TODO current bids

}