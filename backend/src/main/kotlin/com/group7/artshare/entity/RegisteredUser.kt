package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonManagedReference
import lombok.Data
import org.springframework.security.core.userdetails.UserDetails
import javax.persistence.*


@Data
@Entity
class RegisteredUser(

    @OneToOne(cascade = [CascadeType.ALL])
    @JoinColumn(name = "accountInfo", referencedColumnName = "id")
    @JsonManagedReference
    var accountInfo: AccountInfo,

    @ManyToMany(fetch = FetchType.EAGER, cascade =  [CascadeType.MERGE, CascadeType.PERSIST])
    @JoinTable(
        name = "user_authorities",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "authority_id")]
    )
    private val authorities: Set<Authority>
) : UserDetails
{
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( nullable = false)
    var userId: Long = 0L

    @Column
    var isVerified: Boolean = false

    @Column
    var level: Int = 0

    @Column
    var xp: Double = 0.0

    @ManyToMany(mappedBy = "followers", cascade =  [CascadeType.MERGE, CascadeType.PERSIST])
    var following: Set<RegisteredUser> = HashSet()

    @ManyToMany(cascade =  [CascadeType.MERGE, CascadeType.PERSIST])
    var followers: Set<RegisteredUser> = HashSet()

    @ManyToMany(mappedBy = "blockedBy",cascade =  [CascadeType.MERGE, CascadeType.PERSIST])
    var blockedUsers: Set<RegisteredUser> = HashSet()

    @ManyToMany(cascade =  [CascadeType.MERGE, CascadeType.PERSIST])
    var blockedBy: Set<RegisteredUser> = HashSet()

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

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "read_notifications",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "notification_id")]
    )
    var readNotifications: MutableSet<Notification> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "unread_notifications",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "notification_id")]
    )
    var unreadNotifications: MutableSet<Notification> = mutableSetOf()

    //TODO discussion post
    //TODO past reply past posts

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var currentBids: List<Bid> = ArrayList()

    fun getEmail(): String {
        return accountInfo.email
    }
    override fun getAuthorities(): Set<Authority> {
        return authorities
    }
    override fun getPassword(): String {
        return accountInfo.getPassword()
    }

    override fun getUsername(): String? {
        return accountInfo.username
    }

    override fun isAccountNonExpired(): Boolean {
        return true
    }

    override fun isAccountNonLocked(): Boolean {
        return true
    }

    override fun isCredentialsNonExpired(): Boolean {
        return true
    }

    override fun isEnabled(): Boolean {
        return true
    }

}