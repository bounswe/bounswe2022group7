package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonIgnore
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

    @JsonIgnore
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

    @ManyToMany(mappedBy = "upVotedUsers")
    @JsonIgnore
    var upVotedComments: MutableSet<Comment> = mutableSetOf()

    @ManyToMany(mappedBy = "downVotedUsers")
    @JsonIgnore
    var downVotedComments: MutableSet<Comment> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "bookmarked_art_items",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "art_item_id")]
    )
    @JsonManagedReference
    var bookmarkedArtItems: MutableSet<ArtItem> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "bookmarked_events",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "event_id")]
    )
    var bookmarkedEvents: MutableSet<Event> = mutableSetOf()

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


    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL], fetch = FetchType.LAZY)
    @JsonManagedReference
    var writtenDiscussionPosts: MutableList<DiscussionPost> = mutableListOf()

    //TODO past reply past posts

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var currentBids: MutableList<Bid> = mutableListOf()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    @JsonIgnore
    var commentList: MutableList<Comment> = mutableListOf()

    @JsonIgnore
    fun getEmail(): String {
        return accountInfo.email
    }

    @JsonIgnore
    override fun getAuthorities(): Set<Authority> {
        return authorities
    }

    @JsonIgnore
    override fun getPassword(): String {
        return accountInfo.getPassword()
    }

    @JsonIgnore
    override fun getUsername(): String? {
        return accountInfo.username
    }

    @JsonIgnore
    override fun isAccountNonExpired(): Boolean {
        return true
    }

    @JsonIgnore
    override fun isAccountNonLocked(): Boolean {
        return true
    }

    @JsonIgnore
    override fun isCredentialsNonExpired(): Boolean {
        return true
    }

    @JsonIgnore
    override fun isEnabled(): Boolean {
        return true
    }

}