package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonManagedReference
import lombok.Data
import org.springframework.security.core.userdetails.UserDetails
import javax.persistence.*


@Data
@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
open class RegisteredUser(

    @OneToOne(cascade = [CascadeType.ALL])
    @JoinColumn(name = "accountInfo", referencedColumnName = "id")
    @JsonManagedReference
    var accountInfo: AccountInfo,

    @ManyToMany(fetch = FetchType.EAGER, cascade = [CascadeType.MERGE, CascadeType.PERSIST])
    @JoinTable(
        name = "user_authorities",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "authority_id")]
    )
    private val authorities: Set<Authority>
) : UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(nullable = false)
    var id: Long = 0L

    @Column
    var isVerified: Boolean = false

    @Column
    var level: Int = 0

    @Column
    var xp: Double = 0.0

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "followings",
        joinColumns = [JoinColumn(name = "follower_id", referencedColumnName = "id")],
        inverseJoinColumns = [JoinColumn(name = "followed_id", referencedColumnName = "id")]
    )
    var following: MutableSet<RegisteredUser> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "blockings",
        joinColumns = [JoinColumn(name = "blocker_id", referencedColumnName = "id")],
        inverseJoinColumns = [JoinColumn(name = "blocked_id", referencedColumnName = "id")]
    )
    var blockedUsers: MutableSet<RegisteredUser> = mutableSetOf()

    @Column
    var isBanned: Boolean = false

    @ManyToMany(mappedBy = "participants")
    var allEvents: MutableSet<Event> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "bookmarked_art_items",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "art_item_id")]
    )
    var bookmarkedArtItems: MutableSet<ArtItem> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "bookmarked_events",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "event_id")]
    )
    var bookmarkedEvents: MutableSet<Event> = mutableSetOf()


    //TODO discussion post
    //TODO past reply past posts
    //TODO read notifications
    //TODO unread notifications
    //TODO current bids


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