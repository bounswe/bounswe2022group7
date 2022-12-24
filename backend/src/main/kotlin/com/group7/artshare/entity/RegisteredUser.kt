package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonBackReference
import com.fasterxml.jackson.annotation.JsonIdentityInfo
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonManagedReference
import com.fasterxml.jackson.annotation.ObjectIdGenerators
import com.group7.artshare.DTO.RegisteredUserDTO
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
    @JsonManagedReference
    var following: MutableSet<RegisteredUser> = mutableSetOf()

    @ManyToMany(mappedBy = "following" ,cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JsonBackReference
    var followedBy: MutableSet<RegisteredUser> = mutableSetOf()

    @Column
    var isBanned: Boolean = false

    @ManyToMany(mappedBy = "participants")
    @JsonIgnore
    var allEvents: MutableSet<Event> = mutableSetOf()

    @ManyToMany(mappedBy = "upVotedUsers")
    @JsonIgnore
    var upVotedComments: MutableSet<Comment> = mutableSetOf()

    @ManyToMany(mappedBy = "downVotedUsers")
    @JsonIgnore
    var downVotedComments: MutableSet<Comment> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "liked_art_items",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "art_item_id")]
    )
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var likedArtItems: MutableSet<ArtItem> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "bookmarked_art_items",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "art_item_id")]
    )
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var bookmarkedArtItems: MutableSet<ArtItem> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "bookmarked_events",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "event_id")]
    )
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var bookmarkedEvents: MutableSet<Event> = mutableSetOf()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL], fetch = FetchType.LAZY)
    @JsonIgnore
    var writtenDiscussionPosts: MutableList<DiscussionPost> = mutableListOf()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    @JsonIgnore
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
    override fun getUsername(): String {
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
    override fun equals(other: Any?): Boolean {
        if(other == null || other !is RegisteredUser) return false
        if (this === other) return true
        if (username != other.username) return false
        return true
    }

    override fun hashCode(): Int {
        return username.hashCode()
    }

    fun mapToDTO(): RegisteredUserDTO {
        val registeredUserDTO = RegisteredUserDTO()
        registeredUserDTO.id = id
        registeredUserDTO.accountInfo = accountInfo
        registeredUserDTO.isVerified = isVerified
        registeredUserDTO.level = level
        registeredUserDTO.xp = xp
        registeredUserDTO.isBanned = isBanned
        registeredUserDTO.followingUsernames = following.map { it.accountInfo.username }.toMutableSet()
        registeredUserDTO.followedByUsernames = followedBy.map { it.accountInfo.username }.toMutableSet()
        registeredUserDTO.likedArtItemIds = likedArtItems.map { it.id }.toMutableList()
        registeredUserDTO.bookmarkedArtItemIds = bookmarkedArtItems.map { it.id }.toMutableList()
        registeredUserDTO.bookmarkedEventIds = bookmarkedEvents.map { it.id }.toMutableList()
        registeredUserDTO.participatedEventIds = allEvents.map { it.id }.toMutableList()
        registeredUserDTO.discussionPostIds = writtenDiscussionPosts.map { it.id }.toMutableList()
        registeredUserDTO.commentIds = commentList.map { it.id }.toMutableList()
        return registeredUserDTO
    }
}